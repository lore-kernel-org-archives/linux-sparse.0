From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] linux/compiler.h: don't use bool
Date: Fri, 17 Aug 2018 13:43:20 -0700
Message-ID: <688799DE-85EE-4755-A9C6-78312DE2F7A4@joshtriplett.org>
References: <20180817101036.20969-1-linux@rasmusvillemoes.dk> <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On August 17, 2018 1:39:35 PM PDT, Andrew Morton <akpm@linux-foundation.org> wrote:
>On Fri, 17 Aug 2018 12:10:35 +0200 Rasmus Villemoes
><linux@rasmusvillemoes.dk> wrote:
>
>> Appararently, it's possible to have a non-trivial TU include a few
>headers,
>> including linux/build_bug.h, without ending up with linux/types.h. So
>> the 0day bot sent me
>
>What's a "TU"?

Probably "translation unit".
