From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Thu, 3 May 2012 16:52:18 -0700
Message-ID: <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46795 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab2ECXwS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2012 19:52:18 -0400
Received: by yhmm54 with SMTP id m54so2346872yhm.19
        for <linux-sparse@vger.kernel.org>; Thu, 03 May 2012 16:52:18 -0700 (PDT)
In-Reply-To: <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

On Wed, May 2, 2012 at 12:27 AM, Konrad Eisele <eiselekd@gmail.com> wrote:
> But this is the point. All macros are expanded. They disappear completely in
> the pre-processing step. There is no tool at all right now that
> preserves the macro-dependency. Even in IDEs like Eclipse you have tools to show
> macros expansions, but you have no tool to show you in a simple
> way for i.e.:
> #define a
> #ifdef a
> #define b 1
> #endif
> that "#define b 1" is dependent of "#define a" even the "#ifdef a" is
> lost and you have to deduce it yourself from the #line comments.

Sure, so the usage case is mostly for people to understand how
the macro get expanded.

> The information for this is in "struct macro_expansion" of the patch and one can
> build aroung it a trace of the macro expansion. I've done that with a patch for
> gcc and could do it for sparse also. A example is at:
> http://cfw.sourceforge.net/htmltag/init_32.c.pinfo.html
> source at : http://cfw.sourceforge.net/htmltags.html
> i.e. go in init_32.c.pinfo.html to mark_rodata_ro() and click on
> virt_to_page (). A help in in the left pannel.

I agree this is useful. However I feel the original patch is a bit invasive.
How about do it in a step by step way. Make a small patch to allow register
call backs when the macro expands. That way the application using sparse
get notify of the pre-processor macro expands. I can take a look at how to
implement this small patch as well.

If needed, we can make one option that pre-processor don't free the tokens.
In this case, very few changes in the caller side. I feel it cleaner
than changing
the free function behavior.

Chris
