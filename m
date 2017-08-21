From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Question about Sparse parsing of initializers
Date: Mon, 21 Aug 2017 20:29:15 +0100
Message-ID: <CACXZuxdMMvWmyW7THq5se-jf07vVt0kQZg3BOtomV6rKEdyRog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:37589 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753823AbdHUT3R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:29:17 -0400
Received: by mail-vk0-f47.google.com with SMTP id r199so53041348vke.4
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:29:16 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I see a comment in show_initializer_expr() that:

// Initializer indexes and identifiers should
// have been evaluated to EXPR_POS

Does this mean that EXPR_IDENTIFIER and EXPR_INDEX are intermediate
steps that get replaced by EXPR_POS?

Thanks and Regards
Dibyendu
