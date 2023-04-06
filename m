Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E5DC7618D
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Apr 2023 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDFVcu (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjDFVcq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2023 17:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387E6592;
        Thu,  6 Apr 2023 14:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7AE64747;
        Thu,  6 Apr 2023 21:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDCC433EF;
        Thu,  6 Apr 2023 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816764;
        bh=JWuq+EziBNQxuwPJXYAtOnOgUwjkYUyWSc39WtNgEFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qppF1q6r9aR6HLEsvTcAlCsgprvWP519wYwjKuG2GWbxGMFLRj/7zy92kPTDl2gRO
         kwxHtOxjdlpXSobYFijhv8VmzYeImgbfYyCTW0RkKwOC+Ue1oHwn4heNGTF+qlWDDE
         aOjR0Z3rOSNyd7X4UbS6fBw04g0DAWkeEKUBB4mpbDo/+8isblmNqWGzrTZRj8gxH7
         Qi/zs4eXhzQn5AM9pyOnuv1hYQuVNmKKyt54uRZxJc4kzHWwq3hrVf9F/W9HwyhTUl
         GD6TQoL7rlCIz9bzPo4rXA4ldJQ20u1igcDIoPAJm0lVvieehpeBjsolMZPzLBRM1x
         EMaqZ9YAbin2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A0E74052D; Thu,  6 Apr 2023 18:32:42 -0300 (-03)
Date:   Thu, 6 Apr 2023 18:32:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
Message-ID: <ZC86emOOKlgysuwW@kernel.org>
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
 <20230406195830.ieiozetmk7qjllol@revolver>
 <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
 <ZC81Z4p8WnYtVwFT@kernel.org>
 <ZC86NOtaBPi1lhtI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZC86NOtaBPi1lhtI@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Em Thu, Apr 06, 2023 at 06:31:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 06, 2023 at 06:11:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Apr 06, 2023 at 10:02:57PM +0200, Miguel Ojeda escreveu:
> > > On Thu, Apr 6, 2023 at 9:58 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > > >
> > > > Any chance of this being accepted?  I'm looking to use this in the radix
> > > > test suite and would rather not duplicate code.
> > > 
> > > That would be up to the `tools/perf/` maintainers.
> > 
> > Thanks, applied,
> 
> So, I noticed some missing conversions, fixed that, but then when trying
> to test build it with:
> 
> 	make -C tools/perf build-test
> 
> I stumbled on this:
> 
>              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.5AP8tPJgiT
> cd . && make GTK2=1 -j32 DESTDIR=/tmp/tmp.5AP8tPJgiT
>   BUILD:   Doing 'make -j32' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
> <SNIP>
>   CC      trace/beauty/ioctl.o
> In file included from /usr/lib64/glib-2.0/include/glibconfig.h:9,
>                  from /usr/include/glib-2.0/glib/gtypes.h:34,
>                  from /usr/include/glib-2.0/glib/galloca.h:34,
>                  from /usr/include/glib-2.0/glib.h:32,
>                  from /usr/include/glib-2.0/gobject/gbinding.h:30,
>                  from /usr/include/glib-2.0/glib-object.h:24,
>                  from /usr/include/glib-2.0/gio/gioenums.h:30,
>                  from /usr/include/glib-2.0/gio/giotypes.h:30,
>                  from /usr/include/glib-2.0/gio/gio.h:28,
>                  from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
>                  from /usr/include/gtk-2.0/gdk/gdk.h:32,
>                  from /usr/include/gtk-2.0/gtk/gtk.h:32,
>                  from ui/gtk/gtk.h:8,
>                  from ui/gtk/helpline.c:6:
> /usr/include/glib-2.0/glib/gmacros.h:637:28: error: missing ')' after "__has_attribute"
>   637 | #if g_macro__has_attribute(fallthrough)
>       |                            ^~~~~~~~~~~

I'm now trying with:

diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 8f3e43d148a8560b..d2dadf3873fbdf41 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "gtk.h"
 #include "../evsel.h"
 #include "../sort.h"
 #include "../hist.h"
 #include "../helpline.h"
-#include "gtk.h"
 
 #include <signal.h>
 
