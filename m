From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect handling of function pointers
Date: Fri, 10 Mar 2017 14:23:26 +0000
Message-ID: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33480 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937877AbdCJOX2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Mar 2017 09:23:28 -0500
Received: by mail-io0-f178.google.com with SMTP id f84so47967805ioj.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Mar 2017 06:23:27 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

This example fails:

extern int (*f) (int);
int main(int argc, const char *argv[]) {
 if (f) {
  return (*f)(6);
 }
}

The linearized output is:

main:
.L0:
        <entry-point>
        load.64     %r1(f) <- 0[f]
        br          %r1(f), .L1, .L3
.L1:
        load        %r3 <- 0[%r1(f)]
        call.32     %r4 <- %r3, $6
        br          .L3
.L3:
        ret.32      %r4

It is the second load that is failing. Am investigating the cause - it
seems something to do with calc_memop_addr().

Regards
Dibyendu
