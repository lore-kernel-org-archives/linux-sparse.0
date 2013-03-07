From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 06 Mar 2013 20:34:08 -0800
Message-ID: <1362630848.5290.8.camel@joe-AO722>
References: <1362590578.1759.48.camel@joe-AO722>
	 <20130306214550.GA8486@jtriplet-mobl1> <1362607043.2093.19.camel@joe-AO722>
	 <CANeU7Q=vsxomdNSjy+84eTAnRq1OVXynpfkKqfkFGkYhF-FEmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:57847 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756204Ab3CGEeJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 23:34:09 -0500
In-Reply-To: <CANeU7Q=vsxomdNSjy+84eTAnRq1OVXynpfkKqfkFGkYhF-FEmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wed, 2013-03-06 at 20:18 -0800, Chris Li wrote:
> >
> > This still doesn't recompile lib.o every time.
> >
> Ah, I finally get it what you mean the lib.o did not compile every
> time. Here I add a new header file "version.h" which store the
> SPARSE_VERSION. The makefile will regenerate the version.h
> if it does not match the current 'git-describe'. Now lib.o will
> recompile every time you change git branch.
> 
> Joe, I miss your sign off from the patch. Can you sign off on the patch?
> 
> 
> > The "dist" target already has a call to "git describe"; could you unify
> > the two?  (And, ideally, avoid calling git describe twice, once for
> > HAVE_GIT and once for SPARSE_VERSION?)
> 
> That is a very good point. I make change the Makefile to only evaluate it once.
> 
> Chris
> 
> [PATCH] There's no current way to know the version of sparse.  Add
>  --version to see it.
> 
> Signed-off-by: Christopher Li <sparse@chrisli.org>
> ---
>  Makefile | 10 +++++++++-
>  lib.c    | 25 +++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index b195528..35e3801 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,5 +1,13 @@
>  VERSION=0.4.4
> 
> +# Generating file version.h if current version has changed
> +SPARSE_VERSION:=$(shell git describe 2>/dev/null || echo '$(VERSION)')
> +VERSION_H := $(shell cat version.h 2>/dev/null)
> +ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
> +$(info $(shell echo '     GEN      'version.h))
> +$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h)
> +endif
> +
>  OS = linux
> 
> 
> @@ -191,7 +199,7 @@ clean: clean-check
>  	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
> 
>  dist:
> -	@if test "`git describe`" != "v$(VERSION)" ; then \
> +	@if test "v$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
>  		echo 'Update VERSION in the Makefile before running "make dist".' ; \
>  		exit 1 ; \
>  	fi
> diff --git a/lib.c b/lib.c
> index 4f69e11..5e65a0c 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -27,6 +27,7 @@
>  #include "scope.h"
>  #include "linearize.h"
>  #include "target.h"
> +#include "version.h"
> 
>  int verbose, optimize, optimize_size, preprocessing;
>  int die_if_error = 0;
> @@ -646,11 +647,34 @@ static char **handle_base_dir(char *arg, char **next)
>  	return next;
>  }
> 
> +static char **handle_version(char *arg, char **next)
> +{
> +	printf("%s\n", SPARSE_VERSION);
> +	exit(0);
> +}
> +
>  struct switches {
>  	const char *name;
>  	char **(*fn)(char *, char **);
>  };
> 
> +static char **handle_long_options(char *arg, char **next)
> +{
> +	static struct switches cmd[] = {
> +		{ "version", handle_version },
> +		{ NULL, NULL }
> +	};
> +	struct switches *s = cmd;
> +
> +	while (s->name) {
> +		if (!strcmp(s->name, arg))
> +			return s->fn(arg, next);
> +		s++;
> +	}
> +	return next;
> +
> +}
> +
>  static char **handle_switch(char *arg, char **next)
>  {
>  	static struct switches cmd[] = {
> @@ -676,6 +700,7 @@ static char **handle_switch(char *arg, char **next)
>  	case 'G': return handle_switch_G(arg, next);
>  	case 'a': return handle_switch_a(arg, next);
>  	case 's': return handle_switch_s(arg, next);
> +	case '-': return handle_long_options(arg + 1, next);
>  	default:
>  		break;
>  	}



