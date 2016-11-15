From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH] bits_in_bool should be 8
Date: Tue, 15 Nov 2016 08:23:08 +0800
Message-ID: <CANeU7QkTp9O3d4NP+9oW3CUdBvS6-65kByroYj-HhnPv5aUhBA@mail.gmail.com>
References: <1479156643-28563-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33827 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755153AbcKOAXJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 19:23:09 -0500
Received: by mail-it0-f66.google.com with SMTP id q124so18058418itd.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 16:23:09 -0800 (PST)
In-Reply-To: <1479156643-28563-1-git-send-email-jlayton@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 15, 2016 at 4:50 AM, Jeff Layton <jlayton@redhat.com> wrote:
> Given that we're working with byte-addressable machines, each type must
> be at least one byte in size or you'd not be able to take a pointer to
> it.
>
> Noticed at random when I ran the sample "compile" program in the
> sparse source tree vs. a test C program that uses bools. It crashes
> without this patch.

Do you have the test program to crash sparse?

Sparse should handle bool size correctly. The bits_in_bool is
a internal thing for sparse. From sizeof(bool) point of view,
sparse should treat sizeof(bool) as 8 bits. But bool has only
one bit usable value.

Chris
