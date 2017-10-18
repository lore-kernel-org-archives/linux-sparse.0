From: Christopher Li <sparse@chrisli.org>
Subject: [GIT PULL] debug build of sparse v4
Date: Wed, 18 Oct 2017 14:26:18 -0700
Message-ID: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:48532 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbdJRV0T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 17:26:19 -0400
Received: by mail-yw0-f195.google.com with SMTP id q1so1805804ywh.5
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 14:26:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi,

This is the V4 version of the debug build change.

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=debug-target-v4

This change allow sparse to build debug version of sparse
along side of the release version. The debug build of sparse
can be used by patches like ptrlist ref count to check the nest
loop modify usage. The debug build can add other verification feature
that might slow down sparse.

I plan to merge that to master. If there is other objections, it is
a good time to raise it now.

Chris
