From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Potential issue in sparse_file()
Date: Fri, 16 Jun 2017 13:33:46 +0100
Message-ID: <CACXZuxemXEhsWmtB_Y6OD1XrLqCLk=pXqP+Z7NAv7ChWNEFCzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37578 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdFPMds (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 08:33:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id d73so22726871wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 05:33:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I noticed that sparse_file() closes the file descriptor even when it
is 0. Is this the intended behavior?

Regards
Dibyendu
