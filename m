From: Brett Nash <nash@nash.id.au>
Subject: Sparse doesn't seem to care about checking context? data
Date: Tue, 9 Sep 2014 20:51:01 +0000
Message-ID: <20140909205101.GA18784@codekia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from li94-56.members.linode.com ([74.207.252.56]:36232 "EHLO
	ancfirst.codekia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbaIIVWR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Sep 2014 17:22:17 -0400
Received: from nash by ancfirst.codekia.com with local (Exim 4.80)
	(envelope-from <nash@codekia.com>)
	id 1XRSNR-0004vk-Vs
	for linux-sparse@vger.kernel.org; Tue, 09 Sep 2014 20:51:01 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I was just testing sparse on a large (non-linux) code base using the
__must_hold macro (eg __attribute__((context, 1, 1))).

However I don't seem to be able to trigger a warning from it.

I've attached a test case below, is there some magic I need to do get sparse
to trigger on this case.  I also note there are currently no tests in
validation that check for this case.

Regards,
nash

--SLDf9lqlvOQaIe6s
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sparse_context.c"


static int must_hold(int x) __attribute__((context(1,1))) {
	int z;

	return x * 7;
}

static int release(int x) __attribute__((context(1, 0))) {
	__context__(-1);
	return 0;
}

static int acquiresilently(int x) {
	__context__(1);

	return 1;
}

int main(int argc, char **argv) {
	must_hold(8);
	__context__(1);
	must_hold(0);
	__context__(-1);
	return 0;
}

--SLDf9lqlvOQaIe6s--
