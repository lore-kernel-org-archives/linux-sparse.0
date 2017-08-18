From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse-llvm: Incorrect conversion to bool value in CBR: was:
 Investigating a problem
Date: Sat, 19 Aug 2017 00:38:13 +0100
Message-ID: <CACXZuxf8ck5W8kSHeA9pe7YEFgpmpULyBS1nsSrjFEJCVzB9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35928 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdHRXiO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 19:38:14 -0400
Received: by mail-ua0-f178.google.com with SMTP id k43so40510282uaf.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 16:38:14 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

It seems that the function bool_value() in sparse-llvm does not work
if the value is floating point. A more specific conversion is
necessary for floating point to boolean value.

Regards
Dibyendu
