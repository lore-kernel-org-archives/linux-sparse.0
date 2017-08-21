From: Christopher Li <sparse@chrisli.org>
Subject: master merge plans
Date: Mon, 21 Aug 2017 15:39:12 -0400
Message-ID: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:32812 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753222AbdHUTjN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 15:39:13 -0400
Received: by mail-yw0-f178.google.com with SMTP id h127so28500157ywf.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 12:39:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Here is the stuff I am considering:

1) gcc attribute update (trivial and safe to merge)
2) Makefile update to enable debug builds.
    This I want to merge first because it impact a lot of
    Makefile, other patches typically add some source file.
    Which is easy to resolve the conflict than the other way
    around.
    I will send out the update soon
3) Luc's SSSA
    Luc has sssa-mini-v2 now. Is that the latest on to be merged?
    I still want to have option to disable SSSA and option to enable
    old code path. That can be done after the merge though.

Any thing else I missed? Please let me know.


Chris
