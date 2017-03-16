From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Seg fault in linearizer after latest patch series
Date: Thu, 16 Mar 2017 00:24:03 +0000
Message-ID: <CACXZuxd6UpSy=ztcn2nE+58DkimdQ9aaerLQgW7hAJXv1gbmuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36420 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdCPAYG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Mar 2017 20:24:06 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so31782560ioe.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2017 17:24:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

I am getting a segmentation fault in the linearizer - which I
replicated using  your GitHub repository branch llvm-fixes-v2.

Please try -v option when running test-linearizer on this program.
Other programs also cause this. Looks like the offending line is
accessing the def field in a pseudo - and I think one of your recent
changes does not set def anymore?

static double test(double *p)
{
 double x;
 x = *p;
 return x;
}
int main(void)
{

 double u,v;
 v = 42.0;
 u = test(&v);
 return v;
}

Thanks and Regards
Dibyendu
