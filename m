Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64719C433B4
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D00B6140F
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 10:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhDUKbU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:31:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34564 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhDUKbU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Apr 2021 06:31:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAOBFw134312;
        Wed, 21 Apr 2021 10:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=UVRmuI4K82J0Ob8tKR+GphxJcNJedcZ8D33jaobG+i8=;
 b=a/PDaIdrFL5DWiBAP4uQtEXYkYCW7OUow/4TGo68yp4DSFcMEIp4Rbu/wYw/Sta3n6Ez
 4RZoo7oiHql3y7eRTp1yIa76mDtYaj8f9OH7pMWtdzQwBq7huJjiwT4BWpud7djDGjuu
 ELeyFOovGoyNMJA6bAUxBcyTm/kCeCdkrRpa+iYT5IIO3r0iLavdFzOJE13HuKW+90WW
 v81y2CnXZtmcdC6SbTaQytPpUo613eVEy053Dy6OSuyoRU/1m7WHhZqfBS6dDDVDNZpS
 v28O3I2DRockqTxM5yQ4NdztGPLorjbkHcPAVX7JhKGBFPS7Iu1lOxRrCxgPjpkDlOJ8 Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37yn6c9wp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:30:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LAOom5138660;
        Wed, 21 Apr 2021 10:30:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m0d252-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:30:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LAUh9g156959;
        Wed, 21 Apr 2021 10:30:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3809m0d24g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:30:43 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LAUgUI024548;
        Wed, 21 Apr 2021 10:30:42 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 10:30:41 +0000
Date:   Wed, 21 Apr 2021 13:30:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
Message-ID: <20210421103036.GG1981@kadam>
References: <87wnsyzia4.fsf@suse.com>
 <20210420121602.GF1981@kadam>
 <87k0oxyvl3.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0oxyvl3.fsf@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: gASZa8Ut7-4SDafwwETGWET-9sJyMhbf
X-Proofpoint-ORIG-GUID: gASZa8Ut7-4SDafwwETGWET-9sJyMhbf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210080
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Apr 20, 2021 at 02:44:08PM +0200, Aurélien Aptel wrote:
> Hi Dan,
> 
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > Thanks for the idea.  I can implement something like that in Smatch.
> > I'll run the attached check over the kernel and see what it turns up.
> 
> I've only used sparse I think (make C=1) I need to lookup how to use Smatch.
> 
> > It says that it's only checking assignments but the trick is that
> > Smatch creates fake assignments in the background for passing parameters
> > or returning.  So "return a ? uint_val : -ENOMEM;" will trigger an error
> > message.
> 
> Sounds good.
> 
> > If there are too many false positives when I test this tonight, then I
> > may make is_suspicious_int() more strict.
> 
> If that's any help, the exact bug where we hit this is currently in
> fs/cifs/file.c in collect_uncached_write_data(), this line:
> 
> 	ctx->rc = (rc == 0) ? ctx->total_len : rc;
> 
> Hopefully it shows up in your tests.        
>

Yeah.  It finds it.  :)  It works pretty well.  The temptation is to
ignore left shifts.  Otherwise I think I will just push this.

regards,
dan carpenter

fs/f2fs/segment.c:847 __remove_dirty_segment() warn: check sign expansion for '-1'
fs/cifs/file.c:3177 collect_uncached_write_data() warn: check sign expansion for 'rc'
drivers/staging/rtl8188eu/core/rtw_xmit.c:1006 rtw_xmitframe_coalesce() warn: check sign expansion for 'mpdu_len'
drivers/usb/gadget/legacy/inode.c:501 ep_aio_complete() warn: check sign expansion for 'req->status'
drivers/gpu/drm/nouveau/nouveau_hwmon.c:507 nouveau_in_read() warn: check sign expansion for '-19'
drivers/gpu/drm/nouveau/nouveau_hwmon.c:510 nouveau_in_read() warn: check sign expansion for '-19'
drivers/firmware/arm_scpi.c:556 scpi_clk_get_val() warn: check sign expansion for 'ret'
drivers/clk/sunxi-ng/ccu_nm.c:158 ccu_nm_round_rate() warn: check sign expansion for '1 << nm->m.width'
drivers/clk/sunxi-ng/ccu_nm.c:202 ccu_nm_set_rate() warn: check sign expansion for '1 << nm->m.width'
drivers/clk/sunxi-ng/ccu_nkmp.c:149 ccu_nkmp_round_rate() warn: check sign expansion for '1 << nkmp->m.width'
drivers/clk/sunxi-ng/ccu_nkmp.c:151 ccu_nkmp_round_rate() warn: check sign expansion for '1 << ((1 << nkmp->p.width) - 1)'
drivers/clk/sunxi-ng/ccu_nkmp.c:180 ccu_nkmp_set_rate() warn: check sign expansion for '1 << nkmp->m.width'
drivers/clk/sunxi-ng/ccu_nkmp.c:182 ccu_nkmp_set_rate() warn: check sign expansion for '1 << ((1 << nkmp->p.width) - 1)'
drivers/clk/sunxi-ng/ccu_nkm.c:120 ccu_nkm_round_rate() warn: check sign expansion for '1 << nkm->m.width'
drivers/clk/sunxi-ng/ccu_nkm.c:160 ccu_nkm_set_rate() warn: check sign expansion for '1 << nkm->m.width'
drivers/net/ethernet/broadcom/bnxt/bnxt.c:9785 bnxt_show_temp() warn: check sign expansion for 'rc'
drivers/soc/aspeed/aspeed-lpc-snoop.c:98 snoop_file_read() warn: check sign expansion for 'ret'
samples/kfifo/bytestream-example.c:126 fifo_write() warn: check sign expansion for 'ret'
samples/kfifo/bytestream-example.c:142 fifo_read() warn: check sign expansion for 'ret'
samples/kfifo/record-example.c:133 fifo_write() warn: check sign expansion for 'ret'
samples/kfifo/record-example.c:149 fifo_read() warn: check sign expansion for 'ret'
samples/kfifo/inttype-example.c:119 fifo_write() warn: check sign expansion for 'ret'
samples/kfifo/inttype-example.c:135 fifo_read() warn: check sign expansion for 'ret'
net/sunrpc/svcsock.c:1177 svc_tcp_sendto() warn: check sign expansion for 'err'
