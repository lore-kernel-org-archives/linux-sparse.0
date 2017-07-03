From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 0/2] list of gcc supported attribute name
Date: Mon, 3 Jul 2017 11:35:59 -0700
Message-ID: <CANeU7QmC-mpubM+2T-50tqwXbXshpFoYzxg4cTw+t-jQDb-J=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36498 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdGCSgB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 3 Jul 2017 14:36:01 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so98659184pgb.3
        for <linux-sparse@vger.kernel.org>; Mon, 03 Jul 2017 11:36:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This patch add full list of known gcc supported attributes.

So sparse should not give warning on the legit gcc attribute
any more.

Test with full kernel allmodeconfig compile with the exact
same output as before(master branch).

I want to include this two patches in the sparse release 0.5.1.

Git repository here:
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170603

Chris
