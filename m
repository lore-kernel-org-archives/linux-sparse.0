From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [wireless-next:master 70/102]
 drivers/net/wireless/b43/phy_ht.c:338:35: sparse: cast truncates bits from
 constant value (ffff3fff becomes 3fff)
Date: Tue, 16 Sep 2014 10:20:35 +0300
Message-ID: <20140916072035.GG17875@mwanda>
References: <541742fe.FxHiltLcSOUDGDDj%fengguang.wu@intel.com>
 <CACna6ryGg4NY2ecDjCKckXk8QXSJWVpbWWtdya9JRB618G92wQ@mail.gmail.com>
 <20140916021718.GB16455@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47358 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbaIPHVK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Sep 2014 03:21:10 -0400
Content-Disposition: inline
In-Reply-To: <20140916021718.GB16455@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, "John W. Linville" <linville@tuxdriver.com>, kbuild-all@01.org, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 16, 2014 at 10:17:18AM +0800, Fengguang Wu wrote:
> I could disable this warning in my reports, but CC sparse authors
> first to check if there are more elegant solutions.

int main(void)
{
        printf("%x\n", (unsigned short)~(0xc00));   // <-- ok
        printf("%x\n", (unsigned short)~(0xc000));  // <-- complains

        return 0;
}

test.c:10:40: warning: cast truncates bits from constant value (ffff3fff becomes 3fff)

The reason the first one is ok is because we don't complain if the
truncated bits are purely sign bits.  I feel like it should apply to the
second statement as well.  If we're only masking out 0xffff then don't
complain.

regards,
dan carpenter

