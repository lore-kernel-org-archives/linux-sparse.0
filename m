Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F4C77B73
	for <linux-sparse@archiver.kernel.org>; Sat,  6 May 2023 14:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEFO6q (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 May 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEFO6p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 May 2023 10:58:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A181E998
        for <linux-sparse@vger.kernel.org>; Sat,  6 May 2023 07:58:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so4374003a12.2
        for <linux-sparse@vger.kernel.org>; Sat, 06 May 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683385122; x=1685977122;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXjcZ1tP+XcC9VGzMLJ9QRdwU6k1nh7gvXIJbV9ZlJU=;
        b=Z/StALv3qilxFvMxsQdzTQZvNNW8aL1mvKiEmZhavdW44a/SKA0A5+Es+YqYO2ajq3
         MVjoBHdApplqX8lEl2u1F0qs2hCOK0yl5LgxPSF327R94dhpXDis7kjEdeaU1bOp/ttu
         2YYBzGxHbnlvhweXB/K2U9yKWtt7ioYpUgUnum6LEOISFH/0THEQThbPJuaTUY1BJtSf
         ZfmetCmSkyieFx3JFoko3t+rWIGhnKCPxukbD7kqXR+HR7WdTGDNNzKRwLP9cF5iwk97
         pNMP5pS1Ih292IjjEBci+/ezLLaueF53nKsZviMGpgsAYL1SJA5U3bs4YNbdy0NgQijn
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683385122; x=1685977122;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXjcZ1tP+XcC9VGzMLJ9QRdwU6k1nh7gvXIJbV9ZlJU=;
        b=PQHz0R4J0AR0qFE3wLvtm7dxKHKIH1C7l9Ju/B+nO1DnW+1IaVtr0hJvXBGj6CPiaI
         z3kIGy7Xc/KlCqGqGSyKCeFko4IJHl4WdywFXGjpplzaT2rL3BKOHbmYU/uPUBkexSZk
         7UNK9Qh1LQowtUgxWsOmP1t31W2qV/pcTu7RXcqEz/e3Rm+pmSdVdDHjcr3rlYb5NQsg
         eUlczr+a43s4yovZt/xu31+ghR8p7W0tGnugs3nNsCrZ2oeMHxaJIUV7lUEgQTqd44Gn
         Ba0FMhmubmKDjbkQw4TD8MQXYovb9Y//8VJk6W64e2e8og/hlXJryHH8hWGsujpldtt8
         9J8g==
X-Gm-Message-State: AC+VfDypd3rRRALWjjS7Sbpm6ogpnXbzoTcx12TjtY4moFulZ5e7CAX+
        AEf0iECKqPYLQFUgO0aF+a9qT0genTYbzVIERUC24U3cPxY=
X-Google-Smtp-Source: ACHHUZ6afMEGbI9knV0GRgTKrSsTQqMCge2hbSVKcDkKHgsXGN01z/wED2efTHv0Nxh7sac9YW/GPClbyhgdxODb6L4=
X-Received: by 2002:a17:907:608c:b0:94e:6a24:9463 with SMTP id
 ht12-20020a170907608c00b0094e6a249463mr4629722ejc.28.1683385122027; Sat, 06
 May 2023 07:58:42 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Ramon_Vall=C3=A9s_Puig?= <vallespuigramon@gmail.com>
Date:   Sat, 6 May 2023 16:58:31 +0200
Message-ID: <CAMme6D7mQx5m7cbqp641ZfdOeE9UJAHJ_9xT-fAdSD8YMJfm=A@mail.gmail.com>
Subject: Sparse infinite loop
To:     linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,
I have been experiencing a situation in which the free use of global
variables has noticeably hindered my experience with Sparse.

The main issue that I wanted to report is that there is no easy way to
"clean up '' sparse in execution, leading to unexpected behaviour if
Sparse is being run multiple times in a row.

Say for instance that I am running automated tests in a given project
that uses Sparse. Each test will call sparse_initialize() in the start
up, making Sparse fill the hash_table "global" variable with the
different identifiers. But I do not have a possibility to clean up
Sparse in the teardown of the tests. While running sparse in the first
run, hash_table is an array of null pointers ( static struct ident
*hash_table[IDENT_HASH_SIZE]; ) so everything will work as expected.
However, if we run Sparse a second time, hash_table will no longer be
an empty array, instead will contain the artifacts of the first run.
This is an issue, since several functions within tokenize.c use
hash_table to check the existence of an identifier in the hash, and
assign it to the "next" ident, opening the door to a cyclic linked
list: ident =3D ident->next, thus falling in an infinite loop.

The issue can be reproduce just by running:

int main(int argc, char **argv)
{
    struct string_list *filelist =3D NULL;
    sparse_initialize(argc, argv, &filelist); // (1)
    sparse_initialize(argc, argv, &filelist); // (2)
    return 0;
}

this will never terminate as sparse_initialize (2) will most likely
fall in an infinite loop at some point inside create_hashed_ident.

A possible solution would be to add a "clean_up" function in
tokenize.c to reset the hash_table to null pointers which should be
called in between steps (1) and (2).
It would also make sense to add a security check in insert_hash, to
protect ident->next =3D ident.



Maybe I am missing something, but I've been stuck here for a while (bad jok=
e).
I look forward to your reply,
best regards,

Vall=C3=A9s Puig, Ramon
