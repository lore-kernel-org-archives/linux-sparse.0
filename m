From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Issue with bitfield
Date: Sat, 19 Aug 2017 02:24:59 +0100
Message-ID: <CACXZuxeuyK0iJp1h5J8b1BmtTroQVsbfJqkeENG3=uNyyqvDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35074 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdHSBZA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 21:25:00 -0400
Received: by mail-vk0-f44.google.com with SMTP id d124so37279561vkf.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 18:25:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

This test program appears to generate incorrect IR.

extern int printf(const char *s, ...);

int main(void) {
struct { char a:4; char b:4; } x = { 2, 4 };
printf("a=%d b=%d\n", (int)x.a, (int)x.b);
return 0;
}

Regards
Dibyendu
