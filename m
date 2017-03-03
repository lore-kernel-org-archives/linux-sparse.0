From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 05:16:27 +0100
Message-ID: <20170303041625.h23go4vlynqitvy3@macpro.local>
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
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36325 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdCCHEe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 02:04:34 -0500
Received: by mail-wm0-f51.google.com with SMTP id n11so8171150wma.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 23:04:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxfNkXS2qaLW+GoeOZ6TK57jJMzpRNdVCr418Bac-U7=MA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 03, 2017 at 02:52:00AM +0000, Dibyendu Majumdar wrote:
> I think this is because the linearize is outputting an integer cast
> rather than pointer cast so LLVM is not happy.

Yes, it's very possible.
As I said, in another mail yesterday, output_op_ptrcast()
need some changes. It makes the assumption that the cast
is always between type of the same size (and so generate
a LLVM's bitcast). But in sparse, OP_PTRCAST is used for
all cast to a non-void pointer type.

Luc

> p.s. should I start a new thread for each separate issue?

Yes, please.
