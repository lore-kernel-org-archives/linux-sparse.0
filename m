From: Dan Carpenter <error27@gmail.com>
Subject: typedefs and alignment
Date: Mon, 8 Feb 2010 13:35:55 +0300
Message-ID: <20100208103501.GA14210@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f211.google.com ([209.85.220.211]:33309 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab0BHKgJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Feb 2010 05:36:09 -0500
Received: by fxm3 with SMTP id 3so7410220fxm.39
        for <linux-sparse@vger.kernel.org>; Mon, 08 Feb 2010 02:36:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I've found an issue handling typedefs and alignment.  In the appended 
code sparse things 'ptr' has to be aligned so the size of 'bar' is 1024.
I haven't looked at how to fix this at all, I thought I would ask the
experts for hints first.

regards,
dan carpenter

#include <stdio.h>

typedef struct aligned_struct {
	int a;
}  __attribute__ ((aligned(1024))) ali_t;

struct foo {
	int b;
	ali_t *ptr;
};

int mainx(void)
{
	struct foo bar;

	printf("%d\n", sizeof(bar));
	return 0;
}
