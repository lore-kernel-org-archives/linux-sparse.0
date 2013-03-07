From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 06 Mar 2013 20:33:06 -0800
Message-ID: <1362630786.5290.7.camel@joe-AO722>
References: <1362590578.1759.48.camel@joe-AO722>
	 <20130306214550.GA8486@jtriplet-mobl1> <1362607043.2093.19.camel@joe-AO722>
	 <CANeU7Q=vsxomdNSjy+84eTAnRq1OVXynpfkKqfkFGkYhF-FEmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:39024 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757083Ab3CGEdI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 23:33:08 -0500
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

It's your patch now, I was just maybe an instigator.
Looks good though.

If you want:

Reviewed-by: Joe Perches <joe@perches.com>

cheers,  Joe

> @@ -191,7 +199,7 @@ clean: clean-check
>  	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
> 
>  dist:
> -	@if test "`git describe`" != "v$(VERSION)" ; then \
> +	@if test "v$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
>  		echo 'Update VERSION in the Makefile before running "make dist".' ; \

You might make the makefile read the git version
so you don't need to edit Makefile at all.

Maybe something like:

git describe | cut -f1 -d"-"


