From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] add __builtin functions for isinf_sign, isfinite and isnan
Date: Fri, 17 Nov 2017 08:02:02 +0800
Message-ID: <CANeU7Q=hr0OKtHk1gVsN2q1qzUxJ6URFsOY+YQtu_ThrB8UenA@mail.gmail.com>
References: <20171116230817.10011-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42102 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdKQACE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Nov 2017 19:02:04 -0500
Received: by mail-yb0-f195.google.com with SMTP id w203so76972ybe.9
        for <linux-sparse@vger.kernel.org>; Thu, 16 Nov 2017 16:02:04 -0800 (PST)
In-Reply-To: <20171116230817.10011-1-logang@deltatee.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 17, 2017 at 7:08 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> These bultins are defined by in gcc since 4.4. They are also now
> used by the isinf, isfinite and isnan macros. So using them with a
> newer gcc causes 'undefined identifier' errors.
>
> Add the builtin definitions and some validation checks for these
> functions.
>

Thanks, applied and push to master.

>
> Changes since v1:
>  * Remove math.h dependancy from validation tests. As a consequnce
>    we don't test that the math functions work. (Per a request from
>    Christopher.)

Just to clarify. The "make check" is a quick smoke test for sparse to
expose regression etc. It does not mean to be a complete system test.
It is more like a test to be run on before every commit.

In the history we are having header file issue with cygwin and other compile
environment due to sparse don't understand other system macros. It is
better to have sparse able to run the validations test without have to fix
every single system macro define. It is kind of expect to be broken on new
and untested platform. There for, best to have no system header in the
validation test.

Chris
