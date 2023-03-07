Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BCC64EC4
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Mar 2023 00:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCGAyn (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCGAym (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2023 19:54:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020A21A3D
        for <linux-sparse@vger.kernel.org>; Mon,  6 Mar 2023 16:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5796101A
        for <linux-sparse@vger.kernel.org>; Tue,  7 Mar 2023 00:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31AA3C433EF
        for <linux-sparse@vger.kernel.org>; Tue,  7 Mar 2023 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678150480;
        bh=kkUWDxX7Vey2/vzbWUEazgBqSM4IxWK2DnhU7p0QFUw=;
        h=From:To:Subject:Date:From;
        b=uYJT9PoHdPpuxlzwdW6qky7m/DjQsMLfyW9pzQxQkWnZbjG92K54BdD9uaVBl89EM
         dFXttM9MS4eja2+Kz3W/lxYp6XJLN2flKJYlrVPjVOA54OBMkOlPJNcGRLUfuIx60e
         eUKNPaCP14Kcuw/VdO7dngwxj35OMHCx2uV0HOfXOwLicjiZzhPW3thL23sfM+jCZL
         VZg4PmxxpKIWCF91+mvIJeNUFTjA256WcS55JF6D5itC8tqVhL3y5zovnhmCf6I44q
         Wawk0c1vZchM6lOs+k2rP34+MAE+7+4DaNALsgsOXrXdsdORGtCwP6HJRUuqBnjtBq
         6F6T5kLKd7xwA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 086DDC43142; Tue,  7 Mar 2023 00:54:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-sparse@vger.kernel.org
Subject: [Bug 217153] New: [sparse-llvm] Support LLVM 15
Date:   Tue, 07 Mar 2023 00:54:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo tools_sparse@kernel-bugs.kernel.org
X-Bugzilla-Product: Tools
X-Bugzilla-Component: Sparse
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: vladimir.petko@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: tools_sparse@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-217153-200559@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217153

            Bug ID: 217153
           Summary: [sparse-llvm] Support LLVM 15
           Product: Tools
           Version: unspecified
    Kernel Version: Any
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: enhancement
          Priority: P1
         Component: Sparse
          Assignee: tools_sparse@kernel-bugs.kernel.org
          Reporter: vladimir.petko@canonical.com
        Regression: No

Created attachment 303890
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303890&action=3Dedit
remove LLVM 15 deprecated apis

Building sparse-llvm against LLVM 15 results in test failures due to the=20
segmentation faults
https://launchpadlibrarian.net/654787464/sparse_0.6.4-3_amd64-2023-03-06T19=
%3A31%3A07Z.build.
Would it be possible to consider a patch to migrate the sparse-llvm source =
code
to the opaque pointers at some point https://llvm.org/docs/OpaquePointers.h=
tml?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
