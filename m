Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CFEC433F5
	for <linux-sparse@archiver.kernel.org>; Wed, 17 Nov 2021 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348BC61A07
	for <linux-sparse@archiver.kernel.org>; Wed, 17 Nov 2021 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhKQJsa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:48:30 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40247 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235547AbhKQJsS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 17 Nov 2021 04:48:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AAF7D3201DE8;
        Wed, 17 Nov 2021 04:45:17 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Wed, 17 Nov 2021 04:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naive.systems;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=qwtYvO1IWmfqnU/oDXcf/0GhGdE8
        6fgVYRZ9X2PHneQ=; b=VdeMnxKdIbQ1YJcG06pFcpDRQXIx7k5DBLIUGHmtG5rh
        JVw0S14RdTYpQFolZEC072bPw8KuWntAUh58a1AdrxocuAoFUDSAuVEFzejb04VB
        3URw+XE/NHrrHIaDWvA9eA43tGWXWWgihzhSaC0+cWtIJKoV/QUcAwz+3uSG2y8J
        U5Uox0KxK3sJ/2eT3ht8spkCrU7F73j1QTo7EIrEl5BWGJKkELhKTfh89nCPxTq6
        x16pemnkWw2LUCrxFK1b9ByK8erwPjK+JYbr4l7aOEmeHNlesQr0lRVLiF23Ty5X
        4zTA0rxVIPJS0Yd3427ENAttplm4v+uQ4sN1WP3myw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qwtYvO
        1IWmfqnU/oDXcf/0GhGdE86fgVYRZ9X2PHneQ=; b=XJnY46hNjAT3Ev0YyS8I3L
        hUe4TsVQgHJLr5uokZp2YTsc8Cfcoz4f+HCjkBRpgnpieQK3WG0az+zhzs1WpkcW
        e1Qg5uCBRKJ4BOudLxMt9xA/fzTNRQ5ugSypIw9VNnUwF955e3iII8O2lrEAagFI
        cktzG5xNyUGMRjVPX3aRzAsBjUX+BV6Dr3b2asjjdIlt80ETgGIIm13eQV/S1oEm
        Jzhis6QEcMHqDBobf5yYwbSO3dPstWuoy9pntL7Bk7RiS5j3ysejq/tZkyC7nenW
        m48OI1/NFsuaBO6N5PhHds+YKBtdt9ayRTje3YDmidSw0ExqwycLTX6MiFGpSUuw
        ==
X-ME-Sender: <xms:Lc-UYQYrD1UI5laxONcs2uaJY0fVvvVLWpratJV9j1j3jlw2sGAWKg>
    <xme:Lc-UYbbRmv1EWmbTUtwlJqQfyeUdHeoDhxi-uFQF6CDtcXU_8Yyni0Jc0JavlNb6o
    bHGHOe-Gm5B3Jm2T_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdgiihgrohculfhirgdfuceogihjihgrsehnrghivhgvrdhs
    hihsthgvmhhsqeenucggtffrrghtthgvrhhnpefgteefvefhgedufeehhffgudeugfdtke
    ehhedvveehgfekheejheeigeefheekgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpeigjhhirgesnhgrihhvvgdrshihshhtvghmsh
X-ME-Proxy: <xmx:Lc-UYa8mfTJBcx6gHKmF1XB3KGCRF9OC3nFNFIiv6g_w4Xqax2G8UA>
    <xmx:Lc-UYaoeQqBON1AuvT38iA0-FbGVWest95rlc68eOGw2KeQmxLer6A>
    <xmx:Lc-UYbqOr5AT5D_N-IG0PETv9J5BMUSrzy-2W8XOoDVq-4INvT0wDg>
    <xmx:Lc-UYVFFR6LD9K8mUTsb28PUtwwQviJxn9iwLVLO_112PvLosWBHSA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 36FFD218007A; Wed, 17 Nov 2021 04:45:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <fd079590-6715-4840-8943-6627c950962e@www.fastmail.com>
In-Reply-To: <20210813012511.65397-2-duke@naive.systems>
References: <20210726182822.ylmd3vtm44txowoi@mail>
 <20210813012511.65397-1-duke@naive.systems>
 <20210813012511.65397-2-duke@naive.systems>
Date:   Wed, 17 Nov 2021 17:44:56 +0800
From:   "Xiao Jia" <xjia@naive.systems>
To:     luc.vanoostenryck@gmail.com
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/2] expose more functions to C++ in header files
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Luc,

Is this patchset getting your attention?  Ke has finished his internship so if there's anything needed please let me know.

Thanks,
Xiao

On Fri, Aug 13, 2021, at 9:25 AM, Ke Du wrote:
> Delete or shrink the ifndef __cplusplus guard to expose more facilities
> to C++, such as sparse_initialize and the FOR_EACH_PTR macro.
> 
> Signed-off-by: Ke Du <duke@naive.systems>
> Reviewed-by: Xiao Jia <xjia@naive.systems>
> ---
> lib.h     | 4 ++--
> ptrlist.h | 2 +-
> symbol.h  | 3 ---
> token.h   | 3 +--
> 4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/lib.h b/lib.h
> index 9809feee..0e9bd0cd 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -85,8 +85,6 @@ DECLARE_PTR_LIST(string_list, char);
>  
> typedef struct pseudo *pseudo_t;
>  
> -#ifndef __cplusplus
> -
> #ifdef __GNUC__
> #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
> #define NORETURN_ATTR __attribute__ ((__noreturn__))
> @@ -143,6 +141,8 @@ extern struct symbol_list *sparse_keep_tokens(char *filename);
> extern struct symbol_list *sparse(char *filename);
> extern void report_stats(void);
>  
> +#ifndef __cplusplus
> +
> static inline int symbol_list_size(struct symbol_list *list)
> {
> return ptr_list_size((struct ptr_list *)(list));
> diff --git a/ptrlist.h b/ptrlist.h
> index e281309f..67c7a208 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -109,6 +109,7 @@ extern void __free_ptr_list(struct ptr_list **);
> DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##new, \
>    new, __head##new, __list##new, __nr##new, PTR_ENTRY_UNTAG)
>  
> +#endif // __cpluplus
>  
> #define FOR_EACH_PTR(head, ptr) \
> DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __name##ptr, PTR_ENTRY_NOTAG)
> @@ -311,5 +312,4 @@ static inline void *tag_ptr(void *ptr, unsigned long tag)
> return (void *)(tag | (unsigned long)ptr);
> }
>  
> -#endif // __cpluplus
> #endif /* PTR_LIST_H */
> diff --git a/symbol.h b/symbol.h
> index 503c9f09..c9d221e7 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -220,8 +220,6 @@ struct symbol {
> pseudo_t pseudo;
> };
>  
> -#ifndef __cplusplus
> -
> /* Modifiers */
> #define MOD_AUTO 0x00000001
> #define MOD_REGISTER 0x00000002
> @@ -591,5 +589,4 @@ static inline void combine_address_space(struct position pos,
> }
> }
>  
> -#endif // __cplusplus
> #endif /* SYMBOL_H */
> diff --git a/token.h b/token.h
> index 1f3601a9..804cc6f8 100644
> --- a/token.h
> +++ b/token.h
> @@ -197,7 +197,7 @@ struct token {
> };
> };
>  
> -#ifndef __cplusplus
> +
>  
> #define MAX_STRING 8191
>  
> @@ -251,5 +251,4 @@ static inline int match_token_zero(struct token *token)
> return token->number[0] == '0' && !token->number[1];
> }
>  
> -#endif // __cplusplus
> #endif
> -- 
> 2.31.1
> 
> 
