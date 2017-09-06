From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Another code snippet that Sparse has problems with
Date: Thu, 7 Sep 2017 00:05:58 +0100
Message-ID: <CACXZuxeoG1v1y8Jm6kHSrFEad0WJo-kaoWk_QbWAM8hn1R_BwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36833 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbdIFXF7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 19:05:59 -0400
Received: by mail-ua0-f174.google.com with SMTP id q29so13603477uaf.3
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 16:05:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I recently found another test case that fails:

static int test_do(void) {
    int a = 0;
    int count = 27;
    switch (count % 8) {
    case 0: do {  a++;
    case 7:       a++;
    case 6:       a++;
    case 5:       a++;
    case 4:       a++;
    case 3:       a++;
    case 2:       a++;
    case 1:       a++;
            } while ((count -= 8) > 0);
    }
    if (27 != a) return 1;
    return 0;
}

This is a test snippet from 8cc (https://github.com/rui314/8cc) project.


Regards
Dibyendu
