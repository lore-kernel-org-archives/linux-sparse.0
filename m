From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 0/4] dissect: minor fixes/cleanups
Date: Tue, 4 Feb 2020 17:51:19 +0100
Message-ID: <20200204165119.GA24330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24511 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgBDQv3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Feb 2020 11:51:29 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Hello,

Preparations for the new functionality.

Oleg.
---
 dissect.c      | 42 +++++++++++++++++++-----------------------
 test-dissect.c |  7 +++----
 2 files changed, 22 insertions(+), 27 deletions(-)
