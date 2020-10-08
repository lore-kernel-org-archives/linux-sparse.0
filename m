Return-Path: <SRS0=iil9=DP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B0C43467
	for <linux-sparse@archiver.kernel.org>; Thu,  8 Oct 2020 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214142083B
	for <linux-sparse@archiver.kernel.org>; Thu,  8 Oct 2020 10:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgJHKFA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:05:00 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51633 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHKFA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Oct 2020 06:05:00 -0400
X-Originating-IP: 78.45.89.65
Received: from [192.168.1.23] (ip-78-45-89-65.net.upcbroadband.cz [78.45.89.65])
        (Authenticated sender: i.maximets@ovn.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AA4F0C0010;
        Thu,  8 Oct 2020 10:04:56 +0000 (UTC)
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
To:     Ilya Maximets <i.maximets@ovn.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>,
        David Marchand <david.marchand@redhat.com>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
 <20201007231554.d3vgykhycm3pcezg@ltop.local>
 <d7a476f9-0a35-12e9-e8cf-2cdc6521b294@ovn.org>
From:   Ilya Maximets <i.maximets@ovn.org>
Message-ID: <e2a2ef01-7432-9002-9be6-338a118bc4f4@ovn.org>
Date:   Thu, 8 Oct 2020 12:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d7a476f9-0a35-12e9-e8cf-2cdc6521b294@ovn.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 10/8/20 11:13 AM, Ilya Maximets wrote:
> On 10/8/20 1:15 AM, Luc Van Oostenryck wrote:
>> On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
>>> The actual code in question that makes sparse fail
>>> OVS build could be found here:
>>>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238
>>
>> I'm impressed and surprised you're using of includes just for Sparse.
>> I also see that this is since 2011. Just for my curiosity, have
>> you an idea for why exactly this was needed and if it is still
>> really needed?
> 
> There are some Sparse-related headers that could be safely removed now
> because required functionality is already supported by Sparse.  We need
> to clean this up someday, e.g. OVS builds fine without
> include/sparse/threads.h since Sparse 0.5.1.
> 
> However, there are headers that are necessary for successful build.
> There are few classes of issues that these headers are targeted on:
> 
> 1. Missing functionality in Sparse.
> For example, it doesn't know about __builtin_ia32_pause, so we have to have
> include/sparse/xmmintrin.h.
> Sparse also doesn't know __atomic_load_n that comes from some DPDK headers.
> OVS itself avoids using builtin atomics if __CHECKER__ defined.
> DPDK library also has some issues with types in __sync_add_and_fetch, but I
> do not remember exact problem.  We have include/sparse/rte_atomic.h for it.
> These are from the top of my head.  I could go through our specific headers
> and make a list of missing features someday if you're interested.
> 
> 2. Sparse complains on standard libraries.
> Complains on PTHREAD_MUTEX_INITIALIZER: 
>     error: Using plain integer as NULL pointer
> So, we have to have include/sparse/pthread.h.
> Maybe some other examples, but I do not remember right now.
> 
> 3. Issues inside external libraries.
> Ex. numa.h header from libnuma contains non-ANSI function declarations.
> So we have include/sparse/numa.h.
> 
> 4. Issues with restricted types (these are heaviest).
> OVS uses restricted types like 'ovs_be32' inside (with __attribute__((bitwise))),
> but standard functions like htonl() operates with usual 'uint32_t'.  While it's
> safe to use these exact functions, Sparse complains about type mismatch.  One
> option here is to explicitly cast arguments with (OVS_FORCE ovs_be32) each time,
> but that is impractical (too many occurrences, ~4K lines of code only for hton/ntoh
> conversions) and will make code less readable.  Much easier to override these
> functions just for Sparse.  Ex. include/sparse/netinet/in.h.
> 
> Similar issue with some data types that goes from external libraries and system
> headers. e.g. DPDK library operates with its own types like rte_be32_t.  While
> it's completely safe to mix them with ovs_be32, Sparse doesn't know about that,
> because DPDK doesn't mark them as bitwise.  This issue might be fixed on DPDK
> side, I guess.  But Sparse will complain about different types even if these types
> defined in exactly same way.  e.g. following test fails:
> 
> diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
> index 0583461c..9284bd05 100644
> --- a/validation/bitwise-cast.c
> +++ b/validation/bitwise-cast.c
> @@ -35,6 +35,18 @@ static __be32 quuy(void)
>         return (__attribute__((force)) __be32) 1730;
>  }
>  
> +/* Implicit casts of equally defined types, should be legal? */

I do understand why this is illegal.  Otherwise it will be not possible to
create le and be types.  However, since the main purpose of 'bitwise' attribute,
AFAIU, is to create le and be types, maybe it make sense to have 2 different
attributes? e.g. 'bitwise_le' and 'bitwise_be'.  This way Sparse will be able
to detect that 2 different types ovs_be32 and rte_be32_t could be safely mixed,
if both defined with attribute 'bitwise_be' and has same base type uint32_t.

> +typedef u32 __attribute__((bitwise)) __my_be32_1;
> +typedef u32 __attribute__((bitwise)) __my_be32_2;
> +
> +static __my_be32_1 my_type(void)
> +{
> +       __my_be32_2 x = (__attribute__((force)) __my_be32_2) 0x2a;
> +
> +       return x;
> +}
> +
> +
>  /*
>   * check-name: conversions to bitwise types
>   * check-command: sparse -Wbitwise $file
> ---
> 
> bitwise-cast.c:46:16: warning: incorrect type in return expression (different base types)
> bitwise-cast.c:46:16:    expected restricted __my_be32_1
> bitwise-cast.c:46:16:    got restricted __my_be32_2 [usertype] x
> 
> 
> This might be not a full list of issues we have, but this is what I can remember right now.
> 
> Best regards, Ilya Maximets.
> 

