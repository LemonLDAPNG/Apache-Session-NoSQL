#==============================================================================
# Specification file for Apache::Session::NoSQL
#==============================================================================

%define real_name Apache-Session-NoSQL
%define real_version 0.2

#==============================================================================
# Main package
#==============================================================================
Name:           perl-%{real_name}
Version:        %{real_version}
Release:        1%{?dist}
Summary:        NoSQL implementation of Apache::Session
Group:          Applications/System
License:        GPL+ or Artistic
URL:            http://search.cpan.org/dist/Apache-Session-NoSQL/
Source0:        http://search.cpan.org/CPAN/authors/id/G/GU/GUIMARD/%{real_name}-%{real_version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}
BuildArch:      noarch

BuildRequires: perl
BuildRequires: perl(Apache::Session)
BuildRequires: perl(ExtUtils::MakeMaker)

Requires: perl(Apache::Session)                                                                                                                                           
                                                                                                                                                                          
%description                                                                                                                                                              
NoSQL implementation of Apache::Session. Sessions are stored in NoSQL                                                                                                     
bases, like Redis or Cassandra.                                                                                                                                           

%prep
%setup -n %{real_name}-%{real_version} -q

# Redis or Cassandra not mandatory

cat << \EOF > %{name}-req
#!/bin/sh
%{__perl_requires} $* |\
sed -e '/perl(Redis)/d' |\
sed -e '/perl(Net::Cassandra)/d'
EOF

%define __perl_requires %{_builddir}/%{real_name}-%{real_version}/%{name}-req
chmod +x %{__perl_requires}

%if 0%{?rhel} >= 7
%{?perl_default_filter}
%global __requires_exclude perl\\(Redis|perl\\(Net::Cassandra
%endif

%build
perl Makefile.PL INSTALLDIRS="vendor"
%{__make} %{?_smp_mflags}

%install
rm -rf %{buildroot}
%{__make} %{?_smp_mflags}
%{__make} %{?_smp_mflags} install DESTDIR=%{buildroot}

# Remove some unwanted files
find %{buildroot} -name .packlist -exec rm -f {} \;
find %{buildroot} -name perllocal.pod -exec rm -f {} \;

%check
%{__make} %{?_smp_mflags} test

%files
%defattr(-,root,root,-)
%doc %{_mandir}/man3/Apache::Session::*.3pm.gz
%{perl_vendorlib}/Apache/Session/*

%changelog
* Tue Jan 23 2018 Clement Oudot <clem.oudot@gmail.com> - 0.2-1
- Update to 0.2
* Mon Jan 12 2015 Clement Oudot <clem.oudot@gmail.com> - 0.1-1
- First package for 0.1
