Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C2C433ED
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Apr 2021 12:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CBC6113C
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Apr 2021 12:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhDTMQo (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:16:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48524 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTMQo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Apr 2021 08:16:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KC8rJR102975;
        Tue, 20 Apr 2021 12:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yQmv5YAaGTYN7bnih4izezuValH/N9Z4W6H6p6UeGWc=;
 b=X4XjWeG4k6cvKe56IquTochAKXyGLOaqnVGqIp+HCWmmbmAks/dH4+i27jqVGUKcln18
 hBUrMPX3E1xSHRDzX+90JIgjSvtVoYEG+hMHpjQkQU+av+/1s+Awg3ZFgyUA2x9xamYN
 gv8E+QYSgHcJbuuan1V754DrX1XFM6hj6QUlJUII6pTwS5U25x3qNI8buk05eHmcF6Hm
 rCDuvjESNq9KIraMa5LV1gBoBguBPuYQcUvyw268rYksaDX8aiK5oZCM4XM/ReDwbBtH
 s6KbgbTBPJWX+qid/ig7QGnR8H97Irg7t9UI3PGUBJuaK5RQ+1OSc3/SQwv73NC5Q4hi Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnevdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 12:16:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KCAtEH133968;
        Tue, 20 Apr 2021 12:16:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098q3fqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 12:16:08 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KCG8uF149448;
        Tue, 20 Apr 2021 12:16:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38098q3fq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 12:16:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13KCG7Be004898;
        Tue, 20 Apr 2021 12:16:07 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 05:16:07 -0700
Date:   Tue, 20 Apr 2021 15:16:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
Message-ID: <20210420121602.GF1981@kadam>
References: <87wnsyzia4.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnsyzia4.fsf@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: YczIE6bUUZRDM2PYEswrUbFxo-0ws1kk
X-Proofpoint-GUID: YczIE6bUUZRDM2PYEswrUbFxo-0ws1kk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200094
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Thanks for the idea.  I can implement something like that in Smatch.
I'll run the attached check over the kernel and see what it turns up.

It says that it's only checking assignments but the trick is that
Smatch creates fake assignments in the background for passing parameters
or returning.  So "return a ? uint_val : -ENOMEM;" will trigger an error
message.

If there are too many false positives when I test this tonight, then I
may make is_suspicious_int() more strict.

regards,
dan carpenter


/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

/*
 * Type promotion with selects doesn't work how you might expect:
 * 	long foo = bar ? u_int_type : -12;
 * The -12 is promoted to unsigned int and the sign is not expanded.
 *
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

static bool is_select(struct expression *expr)
{
	if (expr->type == EXPR_CONDITIONAL)
		return true;
	if (expr->type == EXPR_SELECT)
		return true;
	return false;
}

static int is_uint(struct expression *expr)
{
	struct symbol *type;

	type = get_type(expr);
	if (type_positive_bits(type) == 32)
		return true;
	return false;
}

static int is_suspicious_int(struct expression *expr)
{
	struct symbol *type;
	struct range_list *rl;

	type = get_type(expr);
	if (type_positive_bits(type) != 31)
		return false;

	get_absolute_rl(expr, &rl);
	if (!sval_is_negative(rl_min(rl)))
		return false;

	return true;
}

static void match_assign(struct expression *expr)
{
	struct expression *right, *one, *two;
	struct symbol *type;
	char *name;

	if (expr->op != '=')
		return;

	right = strip_expr(expr->right);
	if (!is_select(right))
		return;

	type = get_type(expr->left);
	if (type_bits(type) != 64)
		return;

	if (right->cond_true)
		one = right->cond_true;
	else
		one = right->conditional;
	two = right->cond_false;

	if (is_uint(one) && is_suspicious_int(two)) {
		name = expr_to_str(two);
		sm_warning("check sign expansion for '%s'", name);
		free_string(name);
		return;
	}

	if (is_uint(two) && is_suspicious_int(one)) {
		name = expr_to_str(one);
		sm_warning("check sign expansion for '%s'", name);
		free_string(name);
		return;
	}
}

void check_select_type(int id)
{
	my_id = id;
	add_hook(match_assign, RAW_ASSIGNMENT_HOOK);
}
