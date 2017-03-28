From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm load and store sizes are not handled correctly
Date: Tue, 28 Mar 2017 12:42:26 +0100
Message-ID: <CACXZuxd3E8UZA6=dDuesaAHqd5wWF+ZCM_sCa+YYOMhgnpMM8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35795 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932147AbdC1Lme (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 07:42:34 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so108537116itc.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 04:42:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I have this test:

extern int printf(const char *, ...);

int main(void)
{
int x = 6;
const char txt[] = "local string %d %f %f\n";
float g = 4.2;
double e = 42.34;

printf(txt, x, g, e);

return 0;
}

When I generate the linearized output with simplifications disabled, I get:

C:\d\github\dmr_c\tests\bugs>..\..\build\Debug\linearize.exe init1.c
main:
.L0:
        <entry-point>
        store.32    $6 -> 0[x]
        load.184*   %r1 <- 0["local string %d %f %f\n"]
        store.184*  %r1 -> 0[txt]
        set.f32     %r2 <- 4.200000
        store.f32   %r2 -> 0[g]
        set.f64     %r3 <- 42.340000
        store.f64   %r3 -> 0[e]
        symaddr.64* %r4 <- txt
        set.f64     %r5 <- 4.200000
        set.f64     %r6 <- 42.340000
        push.64*    %r4
        push.32     $6
        push.f64    %r5
        push.f64    %r6
        call.32     %r7 <- printf
        phisrc.32   %phi1(return) <- $0
        br          .L1

.L1:
        phi.32      %r8 <- %phi1(return)
        ret.32      $0

What is interesting is that the load and store ops have a size that is
184 bits. This scenario is not handled by sparse-llvm correctly.

Presumably for the store here we need to copy the data? What about the load?

Thanks and Regards
Dibyendu
