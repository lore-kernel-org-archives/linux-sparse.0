Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80822C433EF
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jun 2022 14:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiF3OOl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiF3OOF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jun 2022 10:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DAC9427E9
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jun 2022 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656597590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LxaOFylJkQ/MdwV5aA3pa1YtRMsbn1Q4ucnowsYMktM=;
        b=Dq4zCZi5mKp4cLoMNazGuKrfbbHDn5ZNKneZgzUGcnh/zEEEYSdvil3x9W/oLSKHiXuwA9
        XjwLX8sGBq58a/NdmcQcET0rJcyQ8HFSSIWqRqiPCIhAZIjNsW8uddyVaWOOB20Ehf2pGi
        yfIBsi/t+B7uydLgf73Q3GUUhrqt+YA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-m3lxOeKDO0qqQtyjyl8G3A-1; Thu, 30 Jun 2022 09:59:45 -0400
X-MC-Unique: m3lxOeKDO0qqQtyjyl8G3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8982F1019C83;
        Thu, 30 Jun 2022 13:59:44 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D18018EAD;
        Thu, 30 Jun 2022 13:59:43 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     will@kernel.org
Cc:     peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        akpm@linux-foundation.org, linux-sparse@vger.kernel.org,
        cluster-devel@redhat.com, luc.vanoostenryck@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        aahringo@redhat.com
Subject: [RFC 0/2] refcount: attempt to avoid imbalance warnings
Date:   Thu, 30 Jun 2022 09:59:32 -0400
Message-Id: <20220630135934.1799248-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

This patch tries to avoid some sparse warnings related to
refcount_dec_and_lock() and kref_put_lock().

I send this patch series as RFC because it was necessary to do a kref
change after adding __cond_lock() to refcount_dec_and_lock()
functionality.

For me it looks like we do a lot of acrobatics to avoid sparse warnings
here and I really don't know if it's worth the offer. However this is
what I have now...

- Alex

Alexander Aring (2):
  refcount: add __cond_lock() for conditional lock refcount API
  kref: move kref_put_lock() callback to caller

 include/linux/kref.h     | 24 ++++++++----------------
 include/linux/refcount.h | 21 ++++++++++++++++-----
 lib/refcount.c           | 23 ++++++++++++-----------
 3 files changed, 36 insertions(+), 32 deletions(-)

-- 
2.31.1

