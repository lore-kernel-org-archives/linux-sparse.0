From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-llvm: Incorrect conversion to bool value in CBR: was:
 Investigating a problem
Date: Sat, 19 Aug 2017 02:15:46 +0200
Message-ID: <CAMHZB6HaQuU3e6q=Y0BHQ41u=OFswV4VwRuteiNFMyey6ydRhw@mail.gmail.com>
References: <CACXZuxf8ck5W8kSHeA9pe7YEFgpmpULyBS1nsSrjFEJCVzB9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35914 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdHSAPr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 20:15:47 -0400
Received: by mail-ua0-f182.google.com with SMTP id k43so40667815uaf.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 17:15:47 -0700 (PDT)
In-Reply-To: <CACXZuxf8ck5W8kSHeA9pe7YEFgpmpULyBS1nsSrjFEJCVzB9bw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 19, 2017 at 1:38 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> It seems that the function bool_value() in sparse-llvm does not work
> if the value is floating point. A more specific conversion is
> necessary for floating point to boolean value.

I guess you don't have the patch
https://github.com/lucvoo/sparse/commit/bbbd9f179579a6cea6d8b2ae731fade5ec9a9ee8
and maybe also a whole series dealing with booleans.

If you have any doubt, you can always use my sssa-next on a test case,
this tree contains most of the LLVM fixes, plus others stuff and the new SSA.

With code:
    _Bool foo (float a) { return a; }

You get:
; ModuleID = '<stdin>'
source_filename = "sparse"

define i1 @foo(float %ARG1.) {
L0:
  %R2. = fcmp une float %ARG1., 0.000000e+00
  ret i1 %R2.
}

which is the correct code

-- Luc
