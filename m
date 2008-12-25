From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH]: Makefile automatic header dependency
Date: Thu, 25 Dec 2008 10:30:00 +0100
Message-ID: <20081225093000.GA27896@uranus.ravnborg.org>
References: <70318cbf0812242004v30a91d73x844eca15c2733b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:39267 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYLYJ3g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 04:29:36 -0500
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 9FA37DBAB1
	for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 10:29:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <70318cbf0812242004v30a91d73x844eca15c2733b20@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

Hi Chris.

I tried to apply your patch here.
It was word wrapped but that was easy to fix.

A few comments below.

> Singed-Off-By: Christopher Li<sparse@chrisli.org>

s/Singed/Signed/

> Index: sparse.chrisl/Makefile
> ===================================================================
> --- sparse.chrisl.orig/Makefile
> +++ sparse.chrisl/Makefile
> @@ -8,6 +8,7 @@ CFLAGS = -O2 -finline-functions -fno-str
>  CFLAGS += -Wall -Wwrite-strings
>  LDFLAGS += -g
>  AR = ar
> +PROG_LINK_CMD = $(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^  $($@_EXTRA_OBJS)
> 
>  #
>  # For debugging, uncomment the next one
> @@ -18,6 +19,7 @@ HAVE_LIBXML=$(shell pkg-config --exists
> 
> 
>  CFLAGS += -DGCC_BASE=\"$(shell $(CC) --print-file-name=)\"
> +CFLAGS += -Wp,-MD,$(@D)/.$(@F).d

This works well with gcc - but if we want to build sparse with a wider
set of tool chains then this may fail.

> 
>  DESTDIR=
>  PREFIX=$(HOME)
> @@ -28,16 +30,15 @@ MAN1DIR=$(MANDIR)/man1
>  INCLUDEDIR=$(PREFIX)/include
>  PKGCONFIGDIR=$(LIBDIR)/pkgconfig
> 
> -PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse
> test-linearize example \
> -	 test-unssa test-dissect ctags
> -
> -
> +PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
> +	 test-linearize example test-unssa test-dissect ctags
>  INST_PROGRAMS=sparse cgcc
>  INST_MAN1=sparse.1 cgcc.1
> 
>  ifeq ($(HAVE_LIBXML),yes)
>  PROGRAMS+=c2xml
>  INST_PROGRAMS+=c2xml
> +c2xml_EXTRA_OBJS = `pkg-config --libs libxml-2.0`
>  endif
> 
>  LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
> @@ -98,44 +99,12 @@ install: $(INST_PROGRAMS) $(LIBS) $(LIB_
>  sparse.pc: sparse.pc.in
>  	$(QUIET_GEN)sed
> 's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@libdir@|$(LIBDIR)|g;s|@includedir@|$(INCLUDEDIR)|g'
> sparse.pc.in > sparse.pc

When you are patching the Makefile then I suggest breaking this line up somehow.
Should be a follow-up patch.

> 
> -test-lexing: test-lexing.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -test-parsing: test-parsing.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -test-linearize: test-linearize.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -test-sort: test-sort.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> +	
>  compile: compile.o compile-i386.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
> -
> -obfuscate: obfuscate.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -sparse: sparse.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -graph: graph.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -example: example.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -test-unssa: test-unssa.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -test-dissect: test-dissect.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -ctags: ctags.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
> +	$(PROG_LINK_CMD)
> 
> -c2xml: c2xml.o $(LIBS)
> -	$(QUIET_LINK)$(CC) $(LDFLAGS)  -o $@ $< $(LIBS) `pkg-config --libs libxml-2.0`
> +%: %.o $(LIBS)
> +	$(PROG_LINK_CMD)

Such a catch-all rule may likely give problems 
in the future. But for now it looks good.

I tried with:
$(PROGRAMS): %.o: $(LIBS)

but that failed due to the special treatment of compile
in the rule above.

> 
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
> @@ -143,48 +112,13 @@ $(LIB_FILE): $(LIB_OBJS)
>  $(SLIB_FILE): $(LIB_OBJS)
>  	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
> 
> -evaluate.o: $(LIB_H)
> -expression.o: $(LIB_H)
> -lib.o: $(LIB_H)
> -allocate.o: $(LIB_H)
> -ptrlist.o: $(LIB_H)
> -parse.o: $(LIB_H)
> -pre-process.o: $(LIB_H)
> -scope.o: $(LIB_H)
> -show-parse.o: $(LIB_H)
> -symbol.o: $(LIB_H)
> -expand.o: $(LIB_H)
> -linearize.o: $(LIB_H)
> -flow.o: $(LIB_H)
> -cse.o: $(LIB_H)
> -simplify.o: $(LIB_H)
> -memops.o: $(LIB_H)
> -liveness.o: $(LIB_H)
> -sort.o: $(LIB_H)
> -inline.o: $(LIB_H)
> -target.o: $(LIB_H)
> -test-lexing.o: $(LIB_H)
> -test-parsing.o: $(LIB_H)
> -test-linearize.o: $(LIB_H)
> -test-dissect.o: $(LIB_H)
> -test-unssa.o: $(LIB_H)
> -ctags.o: $(LIB_H)
> -compile.o: $(LIB_H) compile.h
> -compile-i386.o: $(LIB_H) compile.h
> -tokenize.o: $(LIB_H)
> -sparse.o: $(LIB_H)
> -obfuscate.o: $(LIB_H)
> -example.o: $(LIB_H)
> -storage.o: $(LIB_H)
> -dissect.o: $(LIB_H)
> -graph.o: $(LIB_H)
> +include $(wildcard .*.o.d)

This gives a warning when there is no .*.o.d files.
You need to do something like:
$(if $(wildcard .*.o.d), include $(wildcard .*.o.d))


> 
>  c2xml.o: c2xml.c $(LIB_H)
>  	$(QUIET_CC)$(CC) `pkg-config --cflags libxml-2.0` -o $@ -c $(CFLAGS) $<
> 
> -compat-linux.o: compat/strtold.c compat/mmap-blob.c \
> -	$(LIB_H)
> -compat-solaris.o: compat/mmap-blob.c $(LIB_H)
> +compat-linux.o: compat/strtold.c compat/mmap-blob.c
> +compat-solaris.o: compat/mmap-blob.c
>  compat-mingw.o: $(LIB_H)
>  compat-cygwin.o: $(LIB_H)
> 
> @@ -192,7 +126,7 @@ compat-cygwin.o: $(LIB_H)
>  	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
> 
>  clean: clean-check
> -	rm -f *.[oa] *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
> +	rm -f *.[oad] *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
> 
>  dist:
>  	@if test "`git describe`" != "$(VERSION)" ; then \


	Sam
