From: Dave Jones <davej@redhat.com>
Subject: broken 0 sized memset checks?
Date: Tue, 5 Sep 2006 17:05:12 -0400
Message-ID: <20060905210512.GF22261@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:11462 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422645AbWIEU6U (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Sep 2006 16:58:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k85KwJLJ025043
	for <linux-sparse@vger.kernel.org>; Tue, 5 Sep 2006 16:58:19 -0400
Received: from pressure.kernelslacker.org (vpn-248-5.boston.redhat.com [10.13.248.5])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k85KwE9n024441
	for <linux-sparse@vger.kernel.org>; Tue, 5 Sep 2006 16:58:16 -0400
Received: from pressure.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k85L5EiH003087
	for <linux-sparse@vger.kernel.org>; Tue, 5 Sep 2006 17:05:14 -0400
Received: (from davej@localhost)
	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k85L5C9b003086
	for linux-sparse@vger.kernel.org; Tue, 5 Sep 2006 17:05:12 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I ran sparse over the current linux kernel, and noticed this..

drivers/net/chelsio/sge.c:341:9: warning: memset with byte count of 0
drivers/net/chelsio/sge.c:469:9: warning: memset with byte count of 0

The first..

        q->size = p->freelQ_size[i];
        ....
        size = sizeof(struct freelQ_ce) * q->size;
        q->centries = kmalloc(size, GFP_KERNEL);
        if (!q->centries)
            goto err_no_mem;
        memset(q->centries, 0, size);

Looks valid enough, as does the second..

        q->size = p->cmdQ_size[i];
        ....
        size = sizeof(struct cmdQ_ce) * q->size;
        q->centries = kmalloc(size, GFP_KERNEL);
        if (!q->centries)
            goto err_no_mem;
        memset(q->centries, 0, size);

Sparse bug ?

	Dave
