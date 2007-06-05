From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: sparse and ARRAY_SIZE() foolproofing
Date: Tue, 5 Jun 2007 18:18:49 +0400
Message-ID: <20070605141849.GA16475@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:1565 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761140AbXFEOKD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Jun 2007 10:10:03 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

For every valid ARRAY_SIZE() use sparse warns about
"cannot size expression". This is somewhat annoying, because code is OK.

$ cat 1.c
#define BUILD_BUG_ON_ZERO(e) (sizeof(char[1 - 2 * !!(e)]) - 1)
#define __must_be_array(a) BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(typeof(a), typeof(&a[0])))
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

int f(void)
{
        int a[42];

        return ARRAY_SIZE(a);
}
$ sparse 1.c
1.c:9:9: error: cannot size expression
