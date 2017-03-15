From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Potential linearizer over simplication
Date: Wed, 15 Mar 2017 00:00:52 +0000
Message-ID: <CACXZuxcf6TX8=9Cn=oa7-i_ok3KSeDUeyGg3ssdswjUFK=ADbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36927 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdCOAAy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 20:00:54 -0400
Received: by mail-it0-f50.google.com with SMTP id g138so10028083itb.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 17:00:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am investigating a test that is failing. I noticed that the
linearized output for:

static double cbrtl (double x)
{
    int hx;
    double r,s,w;
    double lt;
    unsigned sign;
    union {
 double t;
 unsigned pt[2];
    } ut, ux;
    int n0;
    ut.t = 1.0;
    n0 = (ut.pt[0] == 0);
    ut.t = 0.0;
    ux.t = x;

is this:

cbrtl:
.L0:
 <entry-point>
 load.32     %r2 <- 0[ut]
 seteq.32    %r3 <- %r2, $0
 set.64      %r4 <- 0.000000
 store.64    %r4 -> 0[ut]
 store.64    %arg1 -> 0[ux]

The assignment of 1.0 to ut.t has been skipped. Does this look
correct? Is there a way to switch off optimisation / simplification?

Thanks and Regards
Dibyendu
