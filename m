From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Beautify all & install Makefile targets v2
Date: Tue, 22 May 2007 14:24:50 -0700
Message-ID: <46535FA2.4070208@freedesktop.org>
References: <11798585832088-git-send-email-damien.lespiau@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC461DE9176F0D98318D57609"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:52317 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759230AbXEVVZb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 17:25:31 -0400
In-Reply-To: <11798585832088-git-send-email-damien.lespiau@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC461DE9176F0D98318D57609
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
> Beautify make's output like kbuild or git. The install
> target is especially much more readable.
> make V=3D1 (install) to get back to the old behaviour.

Thinking about this further, I think I like the new output, and the new p=
atch
with broader make compatibility removes the rest of the reservations I ha=
d
about this change.  Applied, thanks.

- Josh Triplett

> Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
> ---
>  Makefile |   70 ++++++++++++++++++++++++++++++++++++++----------------=
-------
>  1 files changed, 43 insertions(+), 27 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 77a6877..5eeffdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -37,68 +37,81 @@ SLIB_FILE=3D libsparse.so
> =20
>  LIBS=3D$(LIB_FILE)
> =20
> +#
> +# Pretty print
> +#
> +V	      =3D @
> +Q	      =3D $(V:1=3D)
> +QUIET_CC      =3D $(Q:@=3D@echo    '     CC     '$@;)
> +QUIET_AR      =3D $(Q:@=3D@echo    '     AR     '$@;)
> +QUIET_GEN     =3D $(Q:@=3D@echo    '     GEN    '$@;)
> +QUIET_LD      =3D $(Q:@=3D@echo    '     LD     '$@;)
> +# We rely on the -v switch of install to print 'file -> $ install_dir/=
file'
> +QUIET_INST_SH =3D $(Q:@=3Decho -n  '     INSTALL  ';)
> +QUIET_INST    =3D $(Q:@=3D@echo -n '     INSTALL  ';)
> +
>  all: $(PROGRAMS) sparse.pc
> =20
>  install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
> -	install -d $(DESTDIR)$(BINDIR)
> -	install -d $(DESTDIR)$(LIBDIR)
> -	install -d $(DESTDIR)$(INCLUDEDIR)/sparse
> -	install -d $(DESTDIR)$(PKGCONFIGDIR)
> -	for f in $(INST_PROGRAMS); do \
> -		install -v $$f $(DESTDIR)$(BINDIR)/$$f || exit 1; \
> +	$(Q)install -d $(DESTDIR)$(BINDIR)
> +	$(Q)install -d $(DESTDIR)$(LIBDIR)
> +	$(Q)install -d $(DESTDIR)$(INCLUDEDIR)/sparse
> +	$(Q)install -d $(DESTDIR)$(PKGCONFIGDIR)
> +	$(Q)for f in $(INST_PROGRAMS); do \
> +		$(QUIET_INST_SH)install -v $$f $(DESTDIR)$(BINDIR)/$$f || exit 1; \
>  	done
> -	for f in $(LIBS); do \
> -		install -m 644 -v $$f $(DESTDIR)$(LIBDIR)/$$f || exit 1; \
> +	$(Q)for f in $(LIBS); do \
> +		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(LIBDIR)/$$f || exi=
t 1; \
>  	done
> -	for f in $(LIB_H); do \
> -		install -m 644 -v $$f $(DESTDIR)$(INCLUDEDIR)/sparse/$$f || exit 1; =
\
> +	$(Q)for f in $(LIB_H); do \
> +		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(INCLUDEDIR)/sparse=
/$$f || exit 1; \
>  	done
> -	install -m 644 -v sparse.pc $(DESTDIR)$(PKGCONFIGDIR)/sparse.pc
> +	$(QUIET_INST)install -m 644 -v sparse.pc $(DESTDIR)$(PKGCONFIGDIR)/sp=
arse.pc
> =20
>  sparse.pc: sparse.pc.in
> -	sed 's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@libdir@|$(LIB=
DIR)|g;s|@includedir@|$(INCLUDEDIR)|g' sparse.pc.in > sparse.pc
> +	$(QUIET_GEN)sed 's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@l=
ibdir@|$(LIBDIR)|g;s|@includedir@|$(INCLUDEDIR)|g' sparse.pc.in > sparse.=
pc
> =20
>  test-lexing: test-lexing.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  test-parsing: test-parsing.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  test-linearize: test-linearize.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  test-sort: test-sort.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  compile: compile.o compile-i386.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
> =20
>  obfuscate: obfuscate.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  sparse: sparse.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  graph: graph.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  example: example.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  test-unssa: test-unssa.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  test-dissect: test-dissect.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  ctags: ctags.o $(LIBS)
> -	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> =20
>  $(LIB_FILE): $(LIB_OBJS)
> -	$(AR) rcs $@ $(LIB_OBJS)
> +	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
> =20
>  $(SLIB_FILE): $(LIB_OBJS)
> -	$(CC) -shared -o $@ $(LIB_OBJS)
> +	$(QUIET_LD)$(CC) -shared -o $@ $(LIB_OBJS)
> =20
>  evaluate.o: $(LIB_H)
>  expression.o: $(LIB_H)
> @@ -141,7 +154,10 @@ compat-mingw.o: $(LIB_H)
>  compat-cygwin.o: $(LIB_H)
> =20
>  pre-process.h:
> -	echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=3Dinclud=
e`\"" > pre-process.h
> +	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-n=
ame=3Dinclude`\"" > pre-process.h
> +
> +.c.o:
> +	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
> =20
>  clean:
>  	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) $(SLIB_FILE) pre-process.=
h sparse.pc



--------------enigC461DE9176F0D98318D57609
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU1+iGJuZRtD+evsRAhK1AJ9HM44IgVpiaDJCHA7hWa8raTiqUwCePKRF
8AW3ud+memixhyUkgnxSWiE=
=ns9o
-----END PGP SIGNATURE-----

--------------enigC461DE9176F0D98318D57609--
