Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D5C433FE
	for <linux-sparse@archiver.kernel.org>; Wed,  9 Dec 2020 02:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E37F23888
	for <linux-sparse@archiver.kernel.org>; Wed,  9 Dec 2020 02:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLICyZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:54:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9557 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgLICyZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Dec 2020 21:54:25 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrM6k55xRzLlYd;
        Wed,  9 Dec 2020 10:53:02 +0800 (CST)
Received: from [10.174.177.230] (10.174.177.230) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 10:53:39 +0800
Subject: Re: sparse annotation for error types?
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     <linux-sparse@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <edwin.peer@broadcom.com>
References: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <20201208132844.GC2767@kadam>
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
Message-ID: <90b556f4-2cf0-a302-fa7b-305cf0d618b5@huawei.com>
Date:   Wed, 9 Dec 2020 10:53:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201208132844.GC2767@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.230]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 2020/12/8 21:28, Dan Carpenter wrote:
> Hi Zhang,
> 
> Are you using Coccinelle to detect these bugs?

In fact, I'm not familiar with Coccinelle, these bugs are reported by robot.

> 
> On Sat, Dec 05, 2020 at 02:32:50PM -0800, Jakub Kicinski wrote:
>> Hi!
>>
>> Recently we've been getting a steady stream of patches from Changzhong
>> to fix missing assignment to error variables before jumping to error
>> cases.
> 
> I've mucked about with this a little in Smatch trying to work out some
> heuristics to use.  I added a warning for a NULL return followed by a
> goto.  Then on Friday I added a warning for a _dev_err() print followed
> by a goto.  But neither of those rules catches the bug fixed by commit
> 4de377b65903 ("net: marvell: prestera: Fix error return code in
> prestera_port_create()"), where the error was invalid data.
> 
> 	if (idx >= size)
> 		goto free_whatever;
> 
> I'm going to print a warning if the function ends in a cleanup block
> that can only be reached by gotos.  We'll see how that works tomorrow.
> 
> static void match_return(struct statement *stmt)
> {
>         struct sm_state *sm, *tmp;
>         sval_t sval;
>         char *name;
>         bool is_last;
> 
> 	// Only complain if the function returns a variable
>         if (!stmt->ret_value || stmt->ret_value->type != EXPR_SYMBOL)
>                 return;
> 
> 	// The function returns an int
>         if (cur_func_return_type() != &int_ctype)
>                 return;
> 
> 	// It's only reachable via a goto
>         if (get_state(my_id, "path", NULL) != &label)
>                 return;
> 
> 	// It returns a negative error code
>         sm = get_extra_sm_state(stmt->ret_value);
>         if (!sm || !estate_rl(sm->state) ||
>             !sval_is_negative(rl_min(estate_rl(sm->state))))
>                 return;
> 
>         FOR_EACH_PTR(sm->possible, tmp) {
> 		// There is at least one path where "ret" is zero
>                 if (estate_get_single_value(tmp->state, &sval) &&
>                     sval.value == 0)
>                         goto warn;
>         } END_FOR_EACH_PTR(tmp);
> 
>         return;
> warn:
> 	// It's the last statement of a function
>         is_last = is_last_stmt(stmt);
> 
>         name = expr_to_str(stmt->ret_value);
>         sm_warning("missing error code '%s' rl='%s' is_last=%d", name, sm->state->name, is_last);
>         free_string(name);
> }
> 
> regards,
> dan carpenter
> 
> .
> 
