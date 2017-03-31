From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Potential issue with handling of va_arg()
Date: Fri, 31 Mar 2017 14:47:44 +0100
Message-ID: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34265 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbdCaNrq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 09:47:46 -0400
Received: by mail-io0-f182.google.com with SMTP id b140so39926588iof.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 06:47:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am investigating a failure in this test:

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

void error_message(const char *fmt, ...) {
va_list argp;
va_start(argp, fmt);
vfprintf(stdout, fmt, argp);
va_end(argp);
}

int main(void)
{
error_message("%s\n", "hello world");
return 0;
}


The linearized output for error_message() is:

rror_message:
.L0:
<entry-point>
store.64    %arg1 -> 0[fmt]
cast.64     %r2 <- (64) fmt
load.64     %r3 <- 0[stdout]
call.32     %r6 <- vfprintf, %r3, %arg1, %r2
ret

Above seems incorrect to me, as %r2 should be pointing to [8]fmt presumably?

Thanks and Regards
Dibyendu
