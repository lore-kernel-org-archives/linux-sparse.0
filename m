Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E193C433B4
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AA06141C
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhDUNrC (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:47:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39770 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhDUNrB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Apr 2021 09:47:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LDiARH007416;
        Wed, 21 Apr 2021 13:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=FHyTa2pFgxqLAhTJs9mN4OBtX6QiP3lLDKV/ZzBhQs4=;
 b=NNsRFhuaLsoNeFG5IJ2dcbzCLiS/ZVYEJweUU7+HVLFIecWpyYnqGDjYeG6YTknwWlrh
 /qll+yeGAeAHO365PgsR4IwOsSGk9sj1SVG7MVp6S950YrPwwfPhAm6f9zTvhDaphzAb
 jxHB5PZnEYxIN1VN3r173dUIPMZphYsKyHsRVBe/IbtOjVJ4PwM4eBCFJC25ZfoVC07v
 BoWbHekv1buHBe3V+oIID9NB9If6qRYb4PMDmFzqn6h2TbkiQpne3lH2sfvPHOIflNz2
 dhWklsJObFo2NEOO2xGENJcYYE6KEZJCX4awVMotWV6d3t+UQGzQcYavNgA8klKHREex 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37yn6cadkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:46:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LDkBuA059621;
        Wed, 21 Apr 2021 13:46:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3809k1x389-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:46:25 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDkP1m060903;
        Wed, 21 Apr 2021 13:46:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3809k1x37v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:46:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LDkOMh012982;
        Wed, 21 Apr 2021 13:46:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:46:24 -0700
Date:   Wed, 21 Apr 2021 16:46:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
Message-ID: <20210421134618.GJ1959@kadam>
References: <87wnsyzia4.fsf@suse.com>
 <20210420121602.GF1981@kadam>
 <87k0oxyvl3.fsf@suse.com>
 <20210421103036.GG1981@kadam>
 <87eef3zrbs.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eef3zrbs.fsf@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: fw82rkaOjDxRTCvQATv1GIc38J_MwDRm
X-Proofpoint-ORIG-GUID: fw82rkaOjDxRTCvQATv1GIc38J_MwDRm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210107
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Apr 21, 2021 at 03:43:03PM +0200, Aurélien Aptel wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > Yeah.  It finds it.  :)  It works pretty well.  The temptation is to
> > ignore left shifts.  Otherwise I think I will just push this.
> 
> Great, glad to hear! I didn't check everything but these ones look like
> real bugs (samples but still):
> 

Yeah.  They mostly are real bugs.  I'm going to send fixes for
everything tomorrow.

regards,
dan carpenter

