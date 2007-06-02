From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [RFC] infinite loop in free_preprocessor_line()
Date: Sun, 3 Jun 2007 01:55:26 +0400
Message-ID: <20070602215526.GA5710@martell.zuzino.mipt.ru>
References: <20070526002437.GB5786@martell.zuzino.mipt.ru> <4658D24E.30607@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:6105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757767AbXFBVtO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Jun 2007 17:49:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so467003ugf
        for <linux-sparse@vger.kernel.org>; Sat, 02 Jun 2007 14:49:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4658D24E.30607@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Sat, May 26, 2007 at 05:35:26PM -0700, Josh Triplett wrote:
> Alexey Dobriyan wrote:
> > While running if-2.c from gcc testsuite sparse goes into infinite loop in
> > free_preprocessor_line().
> > 
> > Trimmed down test-case is
> > 
> > 	#if 1
> > 	#if
> > 
> > (two lines)
> 
> Thanks for this fix.
> 
> Can I get a Signed-off-by for this patch, please?

Sorry, lost email in noise

Patch is Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
