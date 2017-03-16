From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Seg fault in linearizer after latest patch series
Date: Thu, 16 Mar 2017 00:30:06 +0000
Message-ID: <CACXZuxeONJVzyfK=+FOGt1YBUpsiyGiz5-apjcfp-UAouqtDaw@mail.gmail.com>
References: <CACXZuxd6UpSy=ztcn2nE+58DkimdQ9aaerLQgW7hAJXv1gbmuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34363 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdCPAaI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Mar 2017 20:30:08 -0400
Received: by mail-io0-f177.google.com with SMTP id b140so32049006iof.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2017 17:30:07 -0700 (PDT)
In-Reply-To: <CACXZuxd6UpSy=ztcn2nE+58DkimdQ9aaerLQgW7hAJXv1gbmuQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 16 March 2017 at 00:24, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> I am getting a segmentation fault in the linearizer - which I
> replicated using  your GitHub repository branch llvm-fixes-v2.
>
> Please try -v option when running test-linearizer on this program.
> Other programs also cause this. Looks like the offending line is
> accessing the def field in a pseudo - and I think one of your recent
> changes does not set def anymore?
>

Sorry I mean above that it does set def in argument pseudos. So
perhaps a chek is needed when there is an attempt to access def.

Regards
