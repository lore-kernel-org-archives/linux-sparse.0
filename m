From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Understanding how sparse handles multiple input files
Date: Thu, 15 Jun 2017 06:09:37 +0200
Message-ID: <20170615040937.dzeiuvt5ixyv5qtq@ltop.local>
References: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35766 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdFOEJn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 00:09:43 -0400
Received: by mail-wr0-f180.google.com with SMTP id q97so3610317wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 14 Jun 2017 21:09:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 14, 2017 at 10:25:59PM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I am trying to understand what happens when multiple input files are
> given to sparse. Are the symbols from previous files dropped when
> sparse moves on to the next file?
> 
> I see a call to remove_symbol_scope() in end_scope() implying that
> symbols are dropped - but then I am not sure I am understanding this
> correctly.

I never yet looked what's happening exactly but I also had seen
a problem when using multiple files, at least a difference
between sparse & gcc. The difference can quickly be seen
with an input file like:
	int a = 1;
	int foo(void) {}
and then call sparse or gcc with twice the same file, like
'sparse $file.c $file.c' or 'gcc -c $file.c $file.c'.

gcc seems to process the files independently and it will simply
overwrite the first $file.o when processing the second one and
this without giving a warning about 'a' or 'foo()' being redefined.

sparse seems to process the files more as if being concatenated
(even if the file scope is respected) or like it would use
a "super-scope" above the file scope of the input files and
will complain that 'a' and 'foo()' are redefined.

Is it something like this you're seeing with multiple input files?


-- Luc Van Oostenryck
