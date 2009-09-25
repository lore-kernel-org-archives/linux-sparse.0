From: Jeff Layton <jlayton@poochiereds.net>
Subject: new sparse release?
Date: Fri, 25 Sep 2009 08:31:09 -0400
Message-ID: <20090925083109.18353a08@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:32875 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZIYMbH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Sep 2009 08:31:07 -0400
Received: from mail.poochiereds.net ([71.70.153.3])
          by cdptpa-omta01.mail.rr.com with ESMTP
          id <20090925123109946.DUOF1442@cdptpa-omta01.mail.rr.com>
          for <linux-sparse@vger.kernel.org>;
          Fri, 25 Sep 2009 12:31:09 +0000
Received: from tlielax.poochiereds.net (tlielax.poochiereds.net [192.168.1.3])
	by mail.poochiereds.net (Postfix) with ESMTP id 9ED6458167
	for <linux-sparse@vger.kernel.org>; Fri, 25 Sep 2009 08:31:09 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The sparse package in Fedora is based on the latest release of sparse
(0.4.1). That seems to be really old (from 2007) and is lacking
important patches (like the one to ignore the __cold__ attribute).

Would it be possible to cut a newer release sometime in the near future
so that distros can pick up a new official version?

Thanks,
-- 
Jeff Layton <jlayton@poochiereds.net>
