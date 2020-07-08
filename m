Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C7C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BDD20775
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 10:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HtYdqSj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGHKBS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:01:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgGHKBR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 06:01:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0689qZ2U071053;
        Wed, 8 Jul 2020 10:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qGeeqBfb4B3JBrMGyCbTWzEAb8chOA1YYzwiQyLwlCg=;
 b=HtYdqSj0ofgVpUhnDTpmT0Kd9WoopR4hGOHz2IpnJQLMRChYBFd0z7TGLQw2yv9aopPQ
 ZpppJF6EbFqWhfOCxhpTdKbpXnhlt2t5/oStHImxj2QoBVgr1Kl2okV8E4WEcq0v4yQO
 MW6wtKIMcyf7QI0wAjJrdLmJ1cNytx+g4nGh7YAmX+zzfUia7QDwk2QCE8InnrXkX6iv
 U4Et+JMYoXmEwjXVmo6jxeCh2zaFsgtfFk23qAyjSwOIupc1ERhQCOOPqneABMcihhJw
 Q3mpKMH50M0JV1AylF1fMjarCjTuo8XyrzUuippeNODE6WlgT9cMx2ulyarHBaZQBdlY HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 325bgf04v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 10:01:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0689xBMB018147;
        Wed, 8 Jul 2020 09:59:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3233p50tvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 09:59:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0689xAx2021053;
        Wed, 8 Jul 2020 09:59:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 02:59:09 -0700
Date:   Wed, 8 Jul 2020 12:59:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sparse improvements & regressions for Linux v5.7-rc1 -> v5.8-rc1
Message-ID: <20200708095904.GI2549@kadam>
References: <20200708000651.f5bykhd3mhgsbvk7@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708000651.f5bykhd3mhgsbvk7@ltop.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 clxscore=1011
 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080071
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jul 08, 2020 at 02:06:51AM +0200, Luc Van Oostenryck wrote:
> I've finally written a silly script to easily compare my tests
> of Sparse on the kernel. So, it's now easy to share those results.
> 
> It's a comparison of Sparse's unique warnings between v5.7-rc1 &
> v5.8-rc1 on x86-64 (defconfig + allyesconfig). The results are
> quite similar on other architectures.
> 
> Note that the differences can be caused by changes in the kernel
> code or in Sparse code.
> 
> Have fun.
> 

This is quite fun!  Could you post the raw errors from the v5.8-rc1
kernel as well?  Probably it's too big for LKML, so it would have to
be posted to pastebin or something.

regards,
dan carpenter

