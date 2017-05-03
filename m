From: Lance Richardson <lrichard@redhat.com>
Subject: bit-field notation and k&r function syntax
Date: Wed, 3 May 2017 13:10:12 -0400 (EDT)
Message-ID: <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdECRKN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 13:10:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE07461D0D
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2017 17:10:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A48BA62923
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2017 17:10:12 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 99AA618523C4
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2017 17:10:12 +0000 (UTC)
In-Reply-To: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I noticed when browsing parse.c that function parameters declared
using K&R syntax are parsed by calling declaration_list(), which
seems to have been intended for parsing structure member declarations
and accepts bit-field syntax.

So e.g. this is (incorrectly) accepted by sparse:

static int foo(b)
int b: 4;
{
	return 0;
}
