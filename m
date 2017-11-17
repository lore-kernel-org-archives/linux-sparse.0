From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 00/38] Makefile reognization
Date: Fri, 17 Nov 2017 10:23:27 +0100
Message-ID: <20171117092326.jje4m4o5np567y6z@ltop.local>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39799 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757449AbdKQJX2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 04:23:28 -0500
Received: by mail-wm0-f46.google.com with SMTP id l8so5005925wmg.4
        for <linux-sparse@vger.kernel.org>; Fri, 17 Nov 2017 01:23:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

On Sat, Nov 11, 2017 at 03:23:59PM +0100, Luc Van Oostenryck wrote:
> The goal of this series is to reorganize sparse's Makefile
> in order to offer a few features asked by the distros:
> 1) allow CFLAGS & CPPFLAGS to be taken from the command line
> 2) allow PREFIX to be taken from the environment
> Support for pkg-config is removed as well as some old crufts.
> 
> This cleanup is based on a previous series by Uwe Kleine-König
> and further inspired by a patch and a need from Jeff Layton.
> 
> The changes since v1 are:
> *) fold the two patches concerning the removal of shared lib support
> *) remove the patch using git-clean for 'make clean'
> 
> The changes since v2 are:
> *) change a commit message to make explicit the fact that
>    quiet's commands abbreviated part are also issued for V=1
> *) add a convenience rule for running a single test via:
>         make validation/<name-of-testfile>.t
> 
> The changes since v3 are:
> *) make the name 'local.mk' be configurable instead of
>    the renaming that was done.
> *) move '-fno-strict-aliasing' out of the overridable CFLAGS
> *) rename the ...{_OBJS,_LDFLAGS,_LDLIBS} to ...{-objs,-ldflags,-ldlibs}
>    to be consistent about the private 'cflags'.

This has now been pushed to my dev tree at:
	git://github.com/lucvoo/sparse.git master

-- Luc Van Oostenryck 
