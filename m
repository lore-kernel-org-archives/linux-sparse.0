Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5585C433F5
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A544160F58
	for <linux-sparse@archiver.kernel.org>; Tue,  2 Nov 2021 14:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhKBOMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:12:13 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:35972 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231539AbhKBOMM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Nov 2021 10:12:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-GO9t0ZBVOR294RrVOiEXQA-1; Tue, 02 Nov 2021 10:09:36 -0400
X-MC-Unique: GO9t0ZBVOR294RrVOiEXQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE4510042E;
        Tue,  2 Nov 2021 14:07:48 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8AEF6786E;
        Tue,  2 Nov 2021 14:07:46 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: [PATCH 0/3] semind: Index more symbols
Date:   Tue,  2 Nov 2021 15:06:42 +0100
Message-Id: <20211102140645.83081-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gladkov.alexey@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Greetings!

For indexing purposes, macros definitions and typedefs are added to the
semind database. Functions that are not used in the code are also indexed.

Alexey Gladkov (3):
  dissect: Allow to show all symbols
  dissect: Show macro definitions
  dissect: Show typedefs

 dissect.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
 options.c      |  5 +++++
 options.h      |  2 ++
 semind.c       |  1 +
 test-dissect.c |  5 ++++-
 5 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.33.0

