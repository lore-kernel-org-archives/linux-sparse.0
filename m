From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: MOD_TYPEDEF unused?
Date: Tue, 13 Jun 2017 23:01:15 +0100
Message-ID: <CACXZuxcVHQrRNtKGS8mURVuHPUDhwsyF7AFnnvCBpbHb2AwQpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36030 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbdFMWBS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 18:01:18 -0400
Received: by mail-wr0-f172.google.com with SMTP id 36so41085526wry.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 15:01:17 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I was looking at the output of c2xml (actually modified version used
in dmrC project) - and saw that typedefs are not marked in any way.
Digging deeper I found that typedef symbols do not have the
MOD_TYPEDEF set. MOD_USERTYPE is set though.

Is there any harm in setting MOD_TYPEDEF also?

Thanks and Regards

Dibyendu
