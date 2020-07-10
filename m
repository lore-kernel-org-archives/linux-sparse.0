Return-Path: <SRS0=t/C/=AV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB0C433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEEB206E2
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 09:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vaLnWi5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGJJBk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:01:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgGJJBj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Jul 2020 05:01:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A90P2F085962;
        Fri, 10 Jul 2020 09:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=8MUeMa9l1CPaRw5c5O0mdldTbVLp6xGOtUMBDkdgEEk=;
 b=vaLnWi5zngoVi8uHQ/Ab7le/7mRgF2TSGbUMAE07VEGH5qswVjpySpD0okxW8398ALfh
 NgaA1gahkDTeSeTuxrx8/5SHIByCD775jiOHsrh+7X4nbuPsf7n6ug6VdPkaL0qaPrI4
 Qw4znHfpaNFVyh7qXdyUDOa2cojbmTl9sopYazunEH4yT9f+wtRfx9E5KhKTNwbGyaQz
 vSRqXqos2Kygq+LVL/Hv4ABjzrW91aL9BNhPuuz51zCYaCPLg9GB+5JJpgHEbOkNL1ka
 OWY6E0csQ76d3rsreKIRYJ5skBsUIew5OLOJtVuJ0Df3VXhzBMRyuG/DvDdTTNIDEITl dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 325y0ape21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 09:01:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A8xJjR001425;
        Fri, 10 Jul 2020 08:59:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 325k3kpayj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 08:59:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06A8xW54011882;
        Fri, 10 Jul 2020 08:59:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 01:59:32 -0700
Date:   Fri, 10 Jul 2020 11:59:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: using sparse to catch refcount leaks
Message-ID: <20200710085927.GN2549@kadam>
References: <871rlk6630.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rlk6630.fsf@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100061
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Jul 09, 2020 at 05:50:11PM +0200, Aurélien Aptel wrote:
> Hi,
> 
> I was thinking the same mechanism for lock checks (lock() has matching
> unlock()) could be used for detecting refcount leaks (get() has matching
> put()).
> 
> This could be used to catch bugs like that:
> 
> https://lore.kernel.org/linux-cifs/CAH2r5mtJg0OONLuAYmcggj=M3euDDxRa3Y5-_W1=qxwbeZypqA@mail.gmail.com/T/#mf0e0397aa0b63043d7b3bb0981f0b7323713bfdc

You might be better off copying the Smatch's locking test instead of
Sparse's.  Smatch does cross function flow analysis which can help.

In this CIFS case, the leak is on the success path (as well as the
failure path) so my theory would be that it would be caught in testing
and will only cause false positives for static analysis.  I can't see
any automated way to know which success paths should take a reference
and which should not.

regards,
dan carpenter

