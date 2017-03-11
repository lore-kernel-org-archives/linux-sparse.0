From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm op_fpcast implementation missing
Date: Sat, 11 Mar 2017 23:53:53 +0000
Message-ID: <CACXZuxdZDSYP2j-8BJ6X_F9qpYWtdcVqZny06G_Qe0dkv_pOpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37641 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbdCKXxz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 18:53:55 -0500
Received: by mail-it0-f47.google.com with SMTP id g138so14759623itb.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 15:53:54 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

Following test fails:

int main(void)
{
 float f = 'a';
 float g = 97;
 printf("%f %f\n", f, g);
 return 0;
}


Regards
Dibyendu
