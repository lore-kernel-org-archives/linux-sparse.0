Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70021C2BBCD
	for <linux-sparse@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3825823AAA
	for <linux-sparse@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgLHN3o (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:29:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHN3o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Dec 2020 08:29:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DLN7G149793;
        Tue, 8 Dec 2020 13:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PHhSWbqvPHYiI4rMRA7ryUUNNJrMc0nKQ1YVCCWbBzo=;
 b=rtQ+KlZ560UCoqswD3HrmESADOsgGdEMeI49qnZzXhFzP7VSPrJtRQiLifhe52eQ/fEd
 bV3qEKHt4TXWH4AYi7pC7CuDWS59H/I+qfFqS122lvT+/nXShExDrF30WZp4rdbPJqzp
 KkzP5eKv62RN3gaBbeAYkKGlJlohI338LLH2dGVV9qIySpSRljBbSuhkwc5YRruhYXWH
 9pMbCRdPlG/+HRNi4YbfbgGbxECf4TPljONA5/r/mTHuFFtJlhs7xXIk71HYypsnSWHV
 Y5wEbDtIHv8P+udL3vnzscTyqFaECx5M682ewn9uO5Ue5EBhkx96pl+HSbnOx8NyPILE /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825m2q5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 13:28:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DOeaJ030141;
        Tue, 8 Dec 2020 13:28:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kysuyqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 13:28:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8DSp43013011;
        Tue, 8 Dec 2020 13:28:52 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 05:28:50 -0800
Date:   Tue, 8 Dec 2020 16:28:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
        edwin.peer@broadcom.com
Subject: Re: sparse annotation for error types?
Message-ID: <20201208132844.GC2767@kadam>
References: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080081
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Zhang,

Are you using Coccinelle to detect these bugs?

On Sat, Dec 05, 2020 at 02:32:50PM -0800, Jakub Kicinski wrote:
> Hi!
> 
> Recently we've been getting a steady stream of patches from Changzhong
> to fix missing assignment to error variables before jumping to error
> cases.

I've mucked about with this a little in Smatch trying to work out some
heuristics to use.  I added a warning for a NULL return followed by a
goto.  Then on Friday I added a warning for a _dev_err() print followed
by a goto.  But neither of those rules catches the bug fixed by commit
4de377b65903 ("net: marvell: prestera: Fix error return code in
prestera_port_create()"), where the error was invalid data.

	if (idx >= size)
		goto free_whatever;

I'm going to print a warning if the function ends in a cleanup block
that can only be reached by gotos.  We'll see how that works tomorrow.

static void match_return(struct statement *stmt)
{
        struct sm_state *sm, *tmp;
        sval_t sval;
        char *name;
        bool is_last;

	// Only complain if the function returns a variable
        if (!stmt->ret_value || stmt->ret_value->type != EXPR_SYMBOL)
                return;

	// The function returns an int
        if (cur_func_return_type() != &int_ctype)
                return;

	// It's only reachable via a goto
        if (get_state(my_id, "path", NULL) != &label)
                return;

	// It returns a negative error code
        sm = get_extra_sm_state(stmt->ret_value);
        if (!sm || !estate_rl(sm->state) ||
            !sval_is_negative(rl_min(estate_rl(sm->state))))
                return;

        FOR_EACH_PTR(sm->possible, tmp) {
		// There is at least one path where "ret" is zero
                if (estate_get_single_value(tmp->state, &sval) &&
                    sval.value == 0)
                        goto warn;
        } END_FOR_EACH_PTR(tmp);

        return;
warn:
	// It's the last statement of a function
        is_last = is_last_stmt(stmt);

        name = expr_to_str(stmt->ret_value);
        sm_warning("missing error code '%s' rl='%s' is_last=%d", name, sm->state->name, is_last);
        free_string(name);
}

regards,
dan carpenter

