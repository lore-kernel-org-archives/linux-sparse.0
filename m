From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 05:27:54 +0100
Message-ID: <20170303042753.vn4kc474erpnysdm@macpro.local>
References: <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
 <20170302171842.xuk535w6wrfxke3b@macpro.local>
 <20170302200916.4agmd5jihtkzyvp5@macpro.local>
 <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37523 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCCEh1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 23:37:27 -0500
Received: by mail-wm0-f50.google.com with SMTP id n11so6542808wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 20:36:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 03, 2017 at 02:52:00AM +0000, Dibyendu Majumdar wrote:
> I get LLVM assertion failure for following instruction:
> 
> insn cast.64     %r4 <- (64) %r2
> 
> Assertion failed: isa<X>(Val) && "cast<Ty>() argument of incompatible
> type!", file C:\d\llvm-3.9.0.src\include\llvm/Support/Casting.h, line
> 237
> 
> I think this is because the linearize is outputting an integer cast
> rather than pointer cast so LLVM is not happy.

Yes.
Here I have something that talk more to me:
	ZExt only operates on integer
	  %R4 = zext %struct.link_st* %load_target to i8*
 
