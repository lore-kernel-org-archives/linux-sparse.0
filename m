From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 0/4] simple, registrable, promotable & friends
Date: Sat, 19 Aug 2017 07:28:24 -0400
Message-ID: <CANeU7Q=Yb2w9EthKUvbSzMzjZm1c9asb2zGueGGNrj2JdNd-xg@mail.gmail.com>
References: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34464 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdHSL2Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 07:28:25 -0400
Received: by mail-yw0-f170.google.com with SMTP id s143so71432478ywg.1
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 04:28:25 -0700 (PDT)
In-Reply-To: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 17, 2017 at 6:35 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is tosolve the issues with the
> current is_simple_{var,type}():
> - the name was less than optimal, I've choosen 'promotable'
> - fix the case for structs & unions.
>

This series looks fine to me. The SSSA method still have the
question of using C pointers. But that is a separate issue.

Chris
