From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] allow ifdef in macro arguments
Date: Mon, 22 Oct 2007 09:13:02 -0700
Message-ID: <70318cbf0710220913y35ab6128jeb0c0c413e40f22e@mail.gmail.com>
References: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com>
	 <20071021155211.GX8181@ftp.linux.org.uk>
	 <471BE8E8.3020200@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:62377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbXJVQND (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Oct 2007 12:13:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1214078rvb
        for <linux-sparse@vger.kernel.org>; Mon, 22 Oct 2007 09:13:02 -0700 (PDT)
In-Reply-To: <471BE8E8.3020200@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

I want to know the answer too so I can try a different patch
or just forget about it.

Chris

On 10/21/07, Josh Triplett <josh@freedesktop.org> wrote:
> Al Viro wrote:
> > On Sun, Oct 21, 2007 at 02:07:15AM -0700, Christopher Li wrote:
> >> I think some one report it long time ago.
> >
> > It should not accept those.  Undefined behaviour and if you try to actually
> > define the semantics for it, you run into such a pile of corner cases that
> > it's not worth even trying.
>
> Do you think the cases handled by GCC warrant making an attempt and
> warning about it, or should Sparse just throw up its hands and give
> up?
>
> If the latter, should Sparse make any attempt at all to detect
> preprocessor conditionals in macro arguments so it can give a more
> specific warning?
>
> - Josh Triplett
>
>
>
